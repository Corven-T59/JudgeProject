require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "Render application layout" do
    login_user
    before do
      get :edit
    end
    it { should render_with_layout('application') }
  end

  xdescribe "Render clear layout" do
    before do
      get "new"
    end
    it { should render_with_layout('clear') }
  end
end