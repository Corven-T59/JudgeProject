class RegistrationsController < Devise::RegistrationsController
  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :handle)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :handle)
  end
end