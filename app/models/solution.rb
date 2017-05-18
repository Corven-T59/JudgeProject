class Solution < ApplicationRecord
  after_create_commit :run
  after_save :send_response, if: Proc.new { |model| model.id != nil && model.id >0 }

  belongs_to :user
  belongs_to :problem
  belongs_to :contest
  enum language: [:c, :cpp, :java, :csharp, :rb, :py2, :py3]

  validates_presence_of :language, :solutionFile, :user, :problem, :contest

  mount_uploader :solutionFile, SolutionUploader

  def run
    ExecutionsWorker.perform_async(self.id)
  end

  def send_response
    WebNotificationsChannel.broadcast_to(
        self.user,
        title: 'Nueva respuesta!',
        message: "Para su envío #{id} usted obtuvo #{code_to_string(status)}"
    )
  end


  def code_to_string(code)
    return "Not answer yet" if code.nil?
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

end
