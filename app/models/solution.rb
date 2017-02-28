class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :problem

  enum language: [:c, :cpp, :csharp, :py, :rb]

  mount_uploader :solutionFile, SolutionUploader
end
