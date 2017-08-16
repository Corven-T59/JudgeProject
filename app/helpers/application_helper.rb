module ApplicationHelper
	def user_auth_link
    if !user_signed_in?
      link_to("Log in", new_user_session_url) if !user_signed_in?
    end
  end

  def icon_link(icon, path=nil, options={})
    if block_given?
      additional_text = yield(icon)
      link_to(content_tag(:span, nil, class: "glyphicon #{icon}") + additional_text, path, options)
    else
      link_to(content_tag(:span, nil, class: "glyphicon #{icon}"), path, options)
    end
  end
  
  def user_actions_links
    if user_signed_in?
      content_tag(:li,class: :dropdown) do
        link_dd = link_to('#', class: :"dropdown-toggle", role: :button, :"data-toggle" => 'dropdown', :"aria-expanded" => "false" ) do
        	current_user.email.html_safe + content_tag(:span, nil, class: "caret")
	      end
	      ul_dd = content_tag(:ul, class: :"dropdown-menu") do
          content_tag(:li, link_to("Log out", destroy_user_session_url, method: :delete)) +
              content_tag(:li, link_to("Profile", profile_path)) +
              content_tag(:li, link_to("Configuration", edit_user_registration_path))
	      end
	      link_dd + ul_dd
      end
	  end
  end

  def user_menu
    content_tag(:li,user_auth_link) + user_actions_links
  end

  def user_can_edit
    is_admin?
  end

  def is_admin?
    current_user.try(:admin?)
  end

  def current_navbar
    is_a_contest = (controller_name == "contests" &&
        (action_name=="scoreboard" || action_name=="problems")) || (controller_name=="solutions" && params[:contest_id])

    if !current_user && !is_a_contest
      return "basic_navbar"
    elsif current_user.try(:admin?) && !is_a_contest
      return "admin_navbar"
    elsif is_a_contest
      return "contest_navbar"
    end
    return "basic_navbar"
  end

  %w(problem user contest).each do |model|
    define_method "#{model.underscore}_actions" do |param|
      if user_can_edit
        content_tag(:ul, class: "list-inline") do
          links = ""
          links += content_tag (:li) do
            icon_link("glyphicon-pencil", send("edit_#{model}_path", param)) do
              t("actions.edit")
            end
          end
          links += content_tag(:li) do
            icon_link("glyphicon-remove", param, method: :delete, data: {confirm: 'Estás seguro?'}) do
              t("actions.remove")
            end
          end
          links.html_safe
        end       
      end
    end
  end

end
