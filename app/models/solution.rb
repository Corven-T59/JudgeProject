class Solution < ApplicationRecord
  after_create :run_async

  belongs_to :user
  belongs_to :problem
  belongs_to :contest
  has_one :execution

  enum language: [:c, :cpp, :csharp, :py, :rb]

  mount_uploader :solutionFile, SolutionUploader

  def run_async
    SolutionsQueueWorker.perform_async(self.id)
  end
end
