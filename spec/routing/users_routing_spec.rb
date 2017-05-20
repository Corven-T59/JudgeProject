require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/users").to route_to("users#index")
    end

    it "routes registration to #new" do
      expect(:get => "/users/sign_up").to route_to("devise/registrations#new")
    end

    it "routes to #show" do
      expect(:get => "/users/1").to route_to("users#show", :id => "1")
    end

    it "routes to session #create" do
      expect(:post => "/users/sign_in").to route_to("devise/sessions#create")
    end

  end
end
