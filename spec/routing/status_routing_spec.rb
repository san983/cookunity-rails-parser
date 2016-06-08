require "rails_helper"

RSpec.describe StatusController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "tests/monitor").to route_to("status#show")
      expect(get: "status/show").to route_to("status#show")
    end
  end
end
