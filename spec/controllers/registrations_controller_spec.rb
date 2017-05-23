RSpec.describe RegistrationsController, type: :controller do
  describe "Render application layout" do
    before do
      login_user
      get :edit
    end
    it { should render_with_layout('application') }
  end

  describe "Render clear layout" do
    it { should render_with_layout('clear') }
  end
end