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
  def perform(solution_id)
    begin
      solution = Solution.includes(:problem).find(solution_id)
      problem = solution.problem

      run_sh = File.join(Rails.root,"lib","judge","run.sh")
      compare_sh = File.join(Rails.root,"lib","judge","compare.sh")

      path_temp = "/tmp/solution_#{solution_id}"
      team_solution_file = "team_solution.txt"
      source_code = solution.solutionFile.file.file
      input_file = problem.inputFile.file.file
      output_file = problem.outputFile.file.file

      FileUtils.mkdir path_temp
      FileUtils.cp [source_code, input_file, output_file, run_sh], path_temp
      FileUtils.touch File.join(path_temp,team_solution_file)
      system "sudo chmod 777 #{path_temp}"

      source_code = File.join(path_temp,solution.solutionFile.sanitized_file.original_filename)
      input_file= File.join(path_temp,problem.inputFile.sanitized_file.original_filename)
      output_file = File.join(path_temp,problem.outputFile.sanitized_file.original_filename)
      run_sh = File.join(path_temp, "run.sh")

      basename = problem.baseName
      name = problem.name
      time_limit = problem.timeLimit
      lang_name = solution.language

      # parameters are:
      # $1 base_filename
      # $2 source_file
      # $3 input_file
      # $4 languagename
      # $5 problemname
      # $6 timelimit

      cmd =<<END
      cd #{path_temp}
      dos2unix #{source_code}
      dos2unix #{input_file}
      dos2unix #{output_file}
      sudo #{run_sh} #{basename} #{source_code} #{input_file} #{lang_name} '#{name}' #{time_limit}
END
      Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        exit_code = wait_thr.value.exitstatus
        exit_code = 2 if exit_code.to_i == 47
        puts stderr.read
        if exit_code != 0
          execution = solution.build_execution(status: exit_code, runTime: 0)
          execution.save
          return;
        end
        team_solution = stdout.read
        File.open(File.join(path_temp,team_solution_file), 'w') { |file| file.write(team_solution) }
        compare = "#{compare_sh} #{team_solution_file} #{output_file} #{lang_name}"

        Open3.popen3(compare) do |stdin, stdout, stderr, wait_thr|
          exit_code = wait_thr.value.exitstatus
          execution = solution.build_execution(status: exit_code, runTime: 0)
          execution.save
        end
      end
    end
  end
end
