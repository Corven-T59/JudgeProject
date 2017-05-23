class Contest < ApplicationRecord
	has_and_belongs_to_many :problems
	has_and_belongs_to_many :users
	has_many :scoreboards
	has_many :solutions

	validates_presence_of :title, :description, :difficulty, :startDate, :endDate
  validate :dates_are_rigth

  scope :running, -> { where("? > startDate and ? < endDate",DateTime.now,DateTime.now) }
  scope :next_contest, -> { where("startDate > ?", DateTime.now).order(:startDate) }
	enum difficulty: [:easy, :medium, :strict]


	def load_contest_user_information()
		users.includes(solutions: [:execution, :problem]).where(solutions: {contest_id: self.id})
	end

  def next_date
    DateTime.now < self.startDate ? self.startDate : self.endDate
	end

  def status
    current_time = Time.now
    if current_time < startDate
      0
    elsif current_time >= startDate && current_time <= endDate
      1
    else
      2
    end
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
  def dates_are_rigth
    return if !(endDate.present? && startDate.present?)

    contest_duration = self.endDate - self.startDate
    if contest_duration >= 3600 && Time.now < self.startDate
      if status != 0
        errors.add(:endDate, 'You can only update a contest that has not started yet')
      end
    else
      errors.add(:endDate, 'The contest must last at least 1 hour and the start date must not be in the past')
    end
  end


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
      tmp.collect! do |s|
        s.correct ||= 0
        s.inconrrect ||=0
        @correct_answers+= s.correct
        [s.problem_id,{correct: s.correct, incorrect: s.inconrrect, sent_time: s.sent_time}]
      end
      @scores.merge!(Hash[tmp])
		end
	end
end
