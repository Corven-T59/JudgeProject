class Execution < ApplicationRecord
  belongs_to :solution
  validates_presence_of :solution, :status, :runTime
end
