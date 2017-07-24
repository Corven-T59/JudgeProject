require 'net/http'
require 'rest-client'
require 'json'
require 'date'
require 'sidekiq-scheduler'

class CodeforcesWorker
	include Sidekiq::Worker
	CODEFORCES_API_BASE = 'http://codeforces.com/api/'

	def perform
		@last_check_time_unix = get_last_check_time
		save_last_check_time

		if ping_codeforces
			Contest.all.each do |contest|
				if contest.is_active
					update_contest(contest)
				end
			end
		end
	end

	def update_contest(contest)
		users = contest.users
		problems = contest.problems

		users.each do |user|
			if user.handle == nil
				next
			end

			codeforces_response = RestClient.get "http://codeforces.com/api/user.status?handle=" + user.handle + "&from=1&count=10"
			#codeforces_response = RestClient.get 'http://codeforces.com/api/user.status?handle=' + 'hatsumora' +'&from=1&count=10'

			user_problems_codeforces = JSON.parse(codeforces_response)


			user_problems_codeforces["result"].each do |submition|

				if submition["creationTimeSeconds"] <= @last_check_time_unix
					next
				end
				codeforces_problem = submition["problem"]
				problem = problems.where(codeforces_contest_id: codeforces_problem["contestId"], codeforces_index: codeforces_problem["index"])

				if problem.count > 0
					puts "Adding solution to " + user.handle

					solution = Solution.new
					solution.contest = contest
					solution.user = user
					solution.problem = problem.take
					solution.status = translate_veredict(submition["verdict"])
					solution.runtime = submition["timeConsumedMillis"]
					solution.save
				end
			end
		end
	end

	def ping_codeforces
    uri = URI("http://codeforces.com/api/user.status?handle=HatsuMora&from=1&count=10")
		res = Net::HTTP.get_response(uri)
		code = res.code.to_i
		ret = code >= 200 && code < 300
		unless ret
			puts "Warning, Codeforces is not working."
		end

		return ret

	end

	def translate_veredict(veredict)
		case veredict
		when "OK"
			return 4
		else
			return 0
		end
	end

	def get_last_check_time
    if !File.exist?('tmp/last_check_time')
			save_last_check_time
    end
    contents = File.open("tmp/last_check_time", "r") { |file| file.read }
		return contents.to_i
		#return 1451606400
	end
	def save_last_check_time
    File.open("tmp/last_check_time", "w") { |file| file.puts DateTime.now.to_time.to_i }
	end
end






