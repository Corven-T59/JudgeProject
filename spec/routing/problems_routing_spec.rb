require "rails_helper"

RSpec.describe ProblemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/problems").to route_to("problems#index")
    end

    it "routes to #show" do
      expect(:get => "/problems/1").to route_to("problems#show", :id => "1")
    end

  end
end
