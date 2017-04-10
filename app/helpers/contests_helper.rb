module ContestsHelper
	def subscribe_link
		if @contest.users.exists? current_user			
			link_to 'Unsubscribe', unsubscribe_contest_path, method: :post
		else
			link_to 'Subscribe', subscribe_contest_path, method: :post
		end
	end
	def submit_link
    if @contest.users.exists? current_user.try(:id)
			link_to 'Submit', submit_contest_path, method: :get
    end
	end

  def contest_actions_links contest
    content_tag(:ul, class: "list-inline") do
      links = ""
      links += content_tag(:li, link_to('Show ', contest))
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
      puts "DEBUG: "
      puts now.to_s + " < " + end_date.to_s + " = " + (now < end_date).to_s
      puts "Doble debug "
      return "Termina "
    end
    "Terminó "
  end
end
