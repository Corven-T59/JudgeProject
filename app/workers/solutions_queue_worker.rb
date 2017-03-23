require "open3"


# the return code show what happened:
# 0 ok
# 1 compile error
# 2 runtime error
# 3 timelimit exceeded
# other_codes are unknown to boca: in this case BOCA will present the
#                                  last line of standard output to the judge
class SolutionsQueueWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0
  def perform(solution_id)
    begin
      solution = Solution.includes(:problem).find(solution_id)
      problem = solution.problem

      project_directory = %x(pwd).chomp
      run_sh = File.join(project_directory,"lib","judge","run.sh")
      compare_sh = File.join(project_directory,"lib","judge","compare.sh")
      path_temp = "/tmp/solution_#{solution_id}"
      source_code = File.join(project_directory,"public",solution.solutionFile.url)
      input_file = File.join(project_directory,"public",problem.inputFile.url)
      output_file = File.join(project_directory,"public",problem.outputFile.url)
      setup_command = <<END
        mkdir #{path_temp}
        cp #{source_code} #{path_temp}
        cp #{input_file} #{path_temp}
        cp #{output_file} #{path_temp}
END

      res = system(setup_command)
      if !res
        execution = solution.build_execution(status: 1, runTime: 0)
        execution.save
        return;
      end

      source_code = File.join(path_temp,solution.solutionFile.sanitized_file.original_filename)
      input_file= File.join(path_temp,problem.inputFile.sanitized_file.original_filename)
      output_file = File.join(path_temp,problem.outputFile.sanitized_file.original_filename)
      team_solution_name = "team_solution.txt"
      basename = problem.baseName
      name = problem.name
      time_limit = problem.timeLimit
      lang_name = "C++"

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
      #{run_sh} #{basename} #{source_code} #{input_file} #{lang_name} '#{name}' #{time_limit}
END
      puts cmd
      Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        team_solution = stdout.read()
        exit_code = wait_thr.value.exitstatus
        puts "Exit code is: " + exit_code.to_s
        if(exit_code != 0)
          execution = solution.build_execution(status: exit_code, runTime: 0)
          execution.save
          puts "Execution saved"
          return;
        end
        File.open(File.join(path_temp,team_solution_name), 'w') { |file| file.write(team_solution) }
        compare =<<END
        cd #{path_temp}
        #{compare_sh} #{team_solution_name} #{output_file} #{lang_name}
END
        Open3.popen3(compare) do |stdin, stdout, stderr, wait_thr|
          puts stdout.read()
          exit_code = wait_thr.value.exitstatus
          execution = solution.build_execution(status: exit_code, runTime: 0)
          execution.save
          puts "Execution saved"
        end
      end
    end
  end
end
