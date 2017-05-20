require "rails_helper"

RSpec.describe ContestsController, type: :routing do
  describe "routing non protected" do
    it "routes to #index" do
      expect(:get => "/contests").to route_to("contests#index")
    end

    it "routes to #show" do
      expect(:get => "/contests/1").to route_to("contests#show", :id => "1")
    end

    it "routes to #scoreboard" do
      expect(get: "/contests/1/scoreboard").to route_to("contests#scoreboard", id: "1")
    end

    it "Routes to #problems" do
      expect(get: "/contests/1/problems").to route_to("contests#problems", id: "1")
    end
  end
end
