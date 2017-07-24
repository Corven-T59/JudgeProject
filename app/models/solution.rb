class Solution < ApplicationRecord
  after_create_commit :run
  after_save :send_response, if: Proc.new { |model| model.id != nil && model.id >0 }

  validates_presence_of :language, :user, :problem, :contest
  validates_presence_of :solutionFile, unless: :problem_is_codeforces?

  belongs_to :user
  belongs_to :problem
  belongs_to :contest
  enum language: {
      cpp: 0,
      java: 1,
      py2: 2,
      py3: 3,
      codeforces: 100,
  }

  mount_uploader :solutionFile, SolutionUploader
  scope :last_solution_info, -> (user_id) { select(:id, :status, :title, :name).where(user_id: user_id).joins(:contest, :problem).last }
  scope :total_solved, -> (user_id) { where(user_id: user_id, status: 4).distinct.count(:problem_id) }

  def run
    ExecutionsWorker.perform_async(self.id) unless problem_is_codeforces?
  end

  def send_response
    WebNotificationsChannel.broadcast_to(
        self.user,
        title: 'Nueva respuesta!',
        message: "Para su envío #{id} usted obtuvo #{code_to_string(status)}"
    )
  end

  def code_to_string(code)
    return "Not answer yet" if code.nil? || code == 0
    code = code.to_i
    return "Compile Error" if code == 1
    return "Runtime Error" if code == 2
    return "Time Limit Exceeded" if code == 3
    return "OK" if code == 4
    return "White spaces" if code == 5
    return "Wrong Answer"
    # 1 compile error
    # 2 runtime error
    # 3 timelimit exceeded
    # 4 OK
    # 5 White spaces
    # 6 Wrong answer

  end

  private
  def problem_is_codeforces?
    if self.problem != nil
      self.problem.is_codeforces?
    end
  end
end
