class Contest < ApplicationRecord
	has_and_belongs_to_many :problems
	has_and_belongs_to_many :users
	has_many :scoreboards
	has_many :solutions

	validates_presence_of :title, :description, :difficulty, :startDate, :endDate

	enum difficulty: [:easy, :medium, :strict]


	def load_contest_user_information()
		users.includes(solutions: [:execution, :problem]).where(solutions: {contest_id: self.id})
	end

  def next_date
    DateTime.now < self.startDate ? self.startDate : self.endDate
	end

	def scoreboard
		problem_set = self.problems
		scores = self.scoreboards
		users =  self.users.select(:id,:email)
		res = []
		users.each do |user|
      temp = UserScore.new problem_set
      temp.user = user
      temp.add_score scores
      res << temp
    end
    res.sort_by{ |user_score| user_score.correct_answers }.reverse
	end

	private

	class UserScore
		attr_accessor :user
    attr_reader :scores, :correct_answers
		def initialize problem_set
			@scores = {}
      @correct_answers = 0
			problem_set.each do |problem|
				@scores[problem.id] = { correct: 0, incorrect: 0, sent_time: nil}
			end
		end

		def add_score scores
      tmp = scores.select{ |score| score if score.user_id == @user.id}
      tmp.collect!{|s| @correct_answers+= s.correct;  [s.problem_id,{correct: s.correct, incorrect: s.inconrrect, sent_time: s.sent_time}]}
      @scores.merge!(Hash[tmp])
		end

	end
end
