class StadisticsWorker
  include Sidekiq::Worker

  def perform user_id, contest_id, status
    contest_user = ContestsUser.where(user_id: user_id, contest_id: contest_id).take
    Rails.logger.debug "Updating stadistics for uid: #{user_id}, cid: #{contest_id} and status: #{status}"
    # 1 compile error
    # 2 runtime error
    # 3 timelimit exceeded
    # 4 OK
    # 5 White spaces
    # 6 Wrong answer
    if contest_user
      case status
        when 1
          contest_user.ce = (contest_user.ce + 1)
        when 2
          contest_user.re = (contest_user.re + 1)
        when 3
          contest_user.tle = (contest_user.tle + 1)
        when 4
          contest_user.ok = (contest_user.ok + 1)
        when 5..6
          contest_user.wa = (contest_user.wa + 1)
        else
          Rails.logger.debug "Non recognize code on stadistic"
      end
      contest_user.save
    else
      Rails.logger.error "Miss reference on database"
    end
  end
end