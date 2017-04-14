module ContestsHelper
	def subscribe_link contest
		if contest.users.exists? current_user
			link_to 'Unsubscribe', unsubscribe_contest_path(contest), method: :post
		else
			link_to 'Subscribe', subscribe_contest_path(contest), method: :post
    end
	end
	def submit_link contest
    if contest.users.exists? current_user.try(:id)
			link_to 'Submit', submit_contest_path(contest), method: :get
    end
	end

  def contest_actions_links contest
    content_tag(:ul, class: "list-inline") do
      links = ""
      links += content_tag(:li, link_to('Show ', contest))
      links += content_tag(:li, subscribe_link(contest))if contest.endDate > DateTime.now
      links += content_tag(:li, link_to('Scoreboard', scoreboard_contest_path(contest))) if DateTime.now > contest.startDate
      links += content_tag(:li, link_to('Edit ', edit_contest_path(contest))) if user_can_edit
      links += content_tag(:li, link_to('Destroy ', contest, method: :delete, data: {confirm: 'Are you sure?'})) if user_can_edit
      links.html_safe
    end
  end

  def aux_time start_date, end_date
    now = DateTime.now
    if now < start_date
      return "Comienza "
    elsif now >= start_date && end_date > now
      return "Termina "
    end
    "Terminó "
  end

  def flag_and_tries user_score, problem
    total = (user_score.scores[problem[0]][:correct]+user_score.scores[problem[0]][:incorrect])
    return "-" if(total) == 0
    return "(#{total})" if user_score.scores[problem[0]][:correct] == 0
    flag =
      content_tag(:li,nil, class: "fa fa-flag", style: "color: ##{problem[1]};") if user_score.scores[problem[0]][:correct] > 0
    flag + "(#{total})"
  end
end
