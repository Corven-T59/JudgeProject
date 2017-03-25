class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
    #check if the user is an administrator
    def is_admin
    	if current_user != nil
	  	  	if !current_user.admin
	    		redirect_to root_path, :alert => "Access denied"
	      	end
		  else
					redirect_to root_path, :alert => "Access denied"
		  end
  		

    end

end
