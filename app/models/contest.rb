class Contest < ApplicationRecord
	has_and_belongs_to_many :problems
	has_and_belongs_to_many :users
	has_many :solutions
	
	enum difficulty: [:easy, :medium, :strict]
end
