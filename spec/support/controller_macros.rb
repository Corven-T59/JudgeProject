module ControllerMacros
  def login_user
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user, email: "user@a.com")
      sign_in user
    end
  end

  def login_admin
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user, email: "user@a.com", admin: true)
      sign_in user
    end
  end
end