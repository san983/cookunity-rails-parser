require "rails_helper"

module Api::V1
  RSpec.describe CancelMealsController, type: :routing do
    describe "routing" do
      it "routes to #create" do
        expect(:post => "api/v1/cancel_meals").to route_to("api/v1/cancel_meals#create")
      end
    end
  end
end
