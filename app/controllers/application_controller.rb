class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :set_locale

  protected
    #check if the user is an administrator
    def is_admin
    	if current_user != nil
	  	  	if !current_user.admin
            redirect_to root_path, :alert => "Acceso denegado"
	      	end
		  else
        redirect_to root_path, :alert => "Acceso denegado"
		  end
  		

    end

  private

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def layout_by_resource
    if devise_controller?
      return "application" if controller_name == "registrations" && action_name == "edit"
      "clear"
    else
      "application"
    end
  end

end
