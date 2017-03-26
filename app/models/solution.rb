class Solution < ApplicationRecord
  after_create :run_async

  belongs_to :user
  belongs_to :problem
  belongs_to :contest
  has_one :execution, dependent: :destroy

  enum language: [:c, :cpp, :java, :csharp, :rb, :py2, :py3]

  mount_uploader :solutionFile, SolutionUploader

  def run_async
    SolutionsQueueWorker.perform_async(self.id)
  end
end
