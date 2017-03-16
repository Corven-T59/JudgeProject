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
      cp = %x(which cp) || "/bin/cp"
      basename = problem.baseName
      source_code = File.join(project_directory,"public",solution.solutionFile.url)
      input = File.join(project_directory,"public",problem.inputFile.url)
      name = problem.name
      time_limit = problem.timeLimit

      # parameters are:
      # $1 base_filename
      # $2 source_file
      # $3 input_file
      # $4 languagename
      # $5 problemname
      # $6 timelimit

      cmd = "sudo #{run_sh} #{basename} #{source_code} #{input} C++ '#{name}' #{time_limit}"
      puts cmd
      Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        team_solution = stdout.read()
        exit_code = wait_thr.value.exitstatus
        puts "Exit code is: " + exit_code.to_s
        if(exit_code != 0)
          execution = solution.build_execution(status: exit_code, runTime: 0)
          execution.save
          puts "Execution saved"
        end
        # If the solution doesnt have an error still be wrong answer
        File.open("Solution_id_#{solution.id}", 'w') { |file| file.write(team_solution) }
      end
    end
  end
end
