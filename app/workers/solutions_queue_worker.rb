require "open3"

class SolutionsQueueWorker
  include Sidekiq::Worker

  def perform(solution_id)
    begin
      #solution = Solution.includes(:problem).find(solution_id)
      #problem = solution.problem

      project_directory = %x(pwd).chomp
      run_sh = File.join(project_directory,"lib","judge","run.sh")
      compare_sh = File.join(project_directory,"lib","judge","compare.sh")
      path_temp = "/tmp/solution_#{solution_id}"
      cp = %x(which cp) || "/bin/cp"
      unless system("mkdir #{path_temp}") then
      	return; #Todo :Raise an error.
      end

      cmd = "sudo "+run_sh+" source lib/testBoca/source.cpp lib/testBoca/input C++ source 1"
      puts cmd
      Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        puts "Hola mundo\n"
        wait_thr.join()
        puts stdout.gets
        puts wait_thr.value.exitstatus
      end

      system("rm -r #{path_temp}")

    end
  end
end
