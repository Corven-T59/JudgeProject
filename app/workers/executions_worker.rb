require "open3"


# the return code show what happened:
# 0 ok
# 1 compile error
# 2 runtime error
# 3 timelimit exceeded
# other_codes are unknown to boca: in this case BOCA will present the
#                                  last line of standard output to the judge
class ExecutionsWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0
  INPUT_CUSTOM_NAME = "input.custom.in"
  OUTPUT_CUSTOM_NAME = "output.custom.out"
  USER_OUTPUT_FILE = "user_solution.txt"

  def perform(solution_id)
    begin
      @solution = Solution.includes(:problem).find(solution_id)
      @problem = @solution.problem
      @contest = @solution.contest
      setup_env
      if (!@problem.delimiter.nil? && @problem.delimiter.empty?) || @contest.strict?
        if @contest.strict?
          create_one_file @problem.inputFile.sanitized_file.original_filename
          create_one_file @problem.outputFile.sanitized_file.original_filename
        end
        input_file = File.join(@path_temp, @problem.inputFile.sanitized_file.original_filename)
        output_file = File.join(@path_temp, @problem.outputFile.sanitized_file.original_filename)
        run_and_compare input_file, output_file
      else
        run_smart_and_compare
      end
      @solution.save
      clean_directory
    end
  end

  private

  def clean_directory
    # system "sudo rm -r #{@path_temp}" if @path_temp.starts_with?("/tmp/solution_")
  end

  def setup_env
    @path_temp = "/tmp/solution_#{@solution.id}"
    @team_solution_file = USER_OUTPUT_FILE
    @source_code = File.join(@path_temp, @solution.solutionFile.sanitized_file.original_filename)
    @backup_file_names = []

    @backup_file_names << @problem.inputFile.file.filename
    @backup_file_names << @problem.outputFile.file.filename

    run_sh = File.join(Rails.root, "lib", "judge", "run.sh")
    compare_sh = File.join(Rails.root, "lib", "judge", "compare.sh")

    source_code = @solution.solutionFile.file.file
    input_file = @problem.inputFile.file.file
    output_file = @problem.outputFile.file.file

    FileUtils.mkdir @path_temp
    FileUtils.cp [source_code, input_file, output_file, run_sh, compare_sh], @path_temp
    FileUtils.touch File.join(@path_temp, @team_solution_file)
    system "sudo chmod 777 #{@path_temp}"
    system("dos2unix #{File.join(@path_temp, "*")}")

    backup_files
  end

  def run_and_compare(input_file, output_file)
    # parameters are:
    # $1 base_filename
    # $2 source_file
    # $3 input_file
    # $4 languagename
    # $5 problemname
    # $6 timelimit
    # return (on @solution.status):
    # 1 compile error
    # 2 runtime error
    # 3 timelimit exceeded
    # 4 OK
    # 5 White spaces
    # 6 Wrong answer
    run_sh = File.join(@path_temp, "run.sh")
    compare_sh = File.join(@path_temp, "compare.sh")
    basename = @problem.baseName
    name = @problem.name
    time_limit = @problem.timeLimit
    lang_name = @solution.language

    cmd = "cd #{@path_temp}; sudo #{run_sh} #{basename} #{@source_code} #{input_file} #{lang_name} '#{name}' #{time_limit}"
    Rails.logger.debug cmd
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      Rails.logger.debug "Error log:\n#{stderr.read}"
      team_solution = stdout.read
      Rails.logger.debug "Normal output:\n#{team_solution}"
      exit_code = wait_thr.value.exitstatus
      exit_code = 2 if exit_code.to_i == 47
      if exit_code != 0
        @solution.status = exit_code
        return
      end

      File.open(File.join(@path_temp, @team_solution_file), 'w') { |file| file.write(team_solution) }
      team_solution_file = File.join(@path_temp, @team_solution_file)
      compare = "#{compare_sh} #{team_solution_file} #{output_file} #{lang_name}"
      Open3.popen3(compare) do |c_stdin, c_stdout, c_stderr, c_wait_thr|
        exit_code = c_wait_thr.value.exitstatus
        @solution.status= exit_code
      end
    end
  end

  def run_smart_and_compare

    input = create_one_file @backup_file_names[0]
    output = create_one_file @backup_file_names[1]

    run_and_compare input, output

    return if @solution.status == 4 # OK

    restore_backup
    arr_input = create_array_from_file @backup_file_names[0]
    arr_output = create_array_from_file @backup_file_names[1]
    i = 0
    arr_input.zip(arr_output).each do |input, output|
      input_file = dump_var_to_file(input, INPUT_CUSTOM_NAME)
      output_file = dump_var_to_file(output, OUTPUT_CUSTOM_NAME)
      run_and_compare input_file, output_file
      if @solution.status != 4
        @solution.input = input
        @solution.output = output
        @solution.user_output = read_file USER_OUTPUT_FILE
        break
      end
      i = i + 1
    end
  end

  def read_file filename
    str = ""
    open(File.join(@path_temp, filename), 'r') { |f| str = f.read }
    return str
  end

  def create_array_from_file filename
    arr = []
    open(File.join(@path_temp, filename), 'r') do |f|
      str = ""
      f.each_line do |line|
        if line.start_with? @problem.delimiter
          arr << str
          str = ""
        else
          str = str + line
        end
      end
      arr << str if !str.empty?
    end
    return arr
  end

  def dump_var_to_file(var, filename)
    pth = File.join(@path_temp, filename)
    File.open(pth, 'w') { |f| f.write(var) }
    return pth
  end

  def create_one_file filename
    open(File.join(@path_temp, filename), 'r') do |f|
      open("#{File.join(@path_temp, filename)}.tmp", 'w') do |f2|
        f.each_line do |line|
          f2.write(line) unless line.start_with? @problem.delimiter
        end
      end
    end
    FileUtils.mv "#{File.join(@path_temp, filename)}.tmp", File.join(@path_temp, filename)
    return File.join(@path_temp, filename)
  end

  def backup_files
    @backup_file_names.each do |file|
      FileUtils.copy(File.join(@path_temp, file), File.join(@path_temp, "#{file}.bak"))
    end
  end

  def restore_backup
    @backup_file_names.each do |file|
      FileUtils.copy(File.join(@path_temp, "#{file}.bak"), File.join(@path_temp, file))
    end
  end

end
