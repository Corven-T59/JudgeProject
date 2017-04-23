require "rails_helper"

RSpec.describe ContestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/contests").to route_to("contests#index")
    end

    xit "routes to #new" do
      expect(:get => "/contests/new").to route_to("contests#new")
    end

    it "routes to #show" do
      expect(:get => "/contests/1").to route_to("contests#show", :id => "1")
    end

    xit "routes to #edit" do
      expect(:get => "/contests/1/edit").to route_to("contests#edit", :id => "1")
    end

    xit "routes to #create" do
      expect(:post => "/contests").to route_to("contests#create")
    end

    xit "routes to #update via PUT" do
      expect(:put => "/contests/1").to route_to("contests#update", :id => "1")
    end

    xit "routes to #update via PATCH" do
      expect(:patch => "/contests/1").to route_to("contests#update", :id => "1")
    end

    xit "routes to #destroy" do
      expect(:delete => "/contests/1").to route_to("contests#destroy", :id => "1")
    end

  end
end
