class Contest < ApplicationRecord
	has_and_belongs_to_many :problems
	has_and_belongs_to_many :users
	has_many :solutions

	validates_presence_of :title, :description, :difficulty, :startDate, :endDate

	enum difficulty: [:easy, :medium, :strict]


	def load_contest_user_information()
		users.includes(solutions: [:execution, :problem]).where(solutions: {contest_id: self.id})
	end


end
