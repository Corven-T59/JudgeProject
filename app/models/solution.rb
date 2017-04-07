class Solution < ApplicationRecord
  after_create_commit :run

  belongs_to :user
  belongs_to :problem
  belongs_to :contest
  enum language: [:c, :cpp, :java, :csharp, :rb, :py2, :py3]

  validates_presence_of :language, :solutionFile, :user, :problem, :contest

  mount_uploader :solutionFile, SolutionUploader

  def run
    ExecutionsWorker.perform_async(self.id)
  end
end
