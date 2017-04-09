module ApplicationHelper
	def user_auth_link
    if !user_signed_in?
      link_to("Log in", new_user_session_url) if !user_signed_in?
    end
  end

  def user_actions_links
    if user_signed_in?
      content_tag(:li,class: :dropdown) do
        link_dd = link_to('#', class: :"dropdown-toggle", role: :button, :"data-toggle" => 'dropdown', :"aria-expanded" => "false" ) do
        	current_user.email.html_safe + content_tag(:span, nil, class: "caret")
	      end
	      ul_dd = content_tag(:ul, class: :"dropdown-menu") do
	      	content_tag(:li, nil, class: :divider, role: :separator) +
	        content_tag(:li,  link_to("Log out", destroy_user_session_url, method: :delete))

	      end
	      link_dd + ul_dd
	    end
	  end
  end

  def user_menu
    content_tag(:li,user_auth_link) + user_actions_links
  end

  def user_can_edit
    current_user.try(:admin?)
  end

  def current_navbar
    if !current_user && !(controller_name == "contests" && action_name=="scoreboard")
      return "basic_navbar"
    elsif current_user.try(:admin?)
      return "admin_navbar"
    elsif controller_name == "contests" && action_name=="scoreboard"
      return "contest_navbar"
    end
    return "basic_navbar"
  end
end
