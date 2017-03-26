class Contest < ApplicationRecord
	has_and_belongs_to_many :problems
	has_and_belongs_to_many :users
	has_many :solutions

	validates_presence_of :title, :description, :difficulty, :startDate, :endDate

	enum difficulty: [:easy, :medium, :strict]
end
