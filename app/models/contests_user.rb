class ContestsUser < ApplicationRecord
  scope :stadistics, -> { select("user_id as id, sum(ok) as total_ok,"+
                                     " sum(wa) as total_wa, sum(ce) as total_ce,"+
                                     " sum(re) as total_re, sum(tle) as total_tle,"+
                                     "count(contest_id) as total_contests")
                              .group(:user_id) }
end