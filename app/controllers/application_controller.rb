class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource

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

  def layout_by_resource
    if devise_controller?
      return "application" if controller_name == "registrations" && action_name == "edit"
      "clear"
    else
      "application"
    end
  end
end
