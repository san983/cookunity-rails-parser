require "rails_helper"

module Api
  module V1
    RSpec.describe OrdersController, type: :routing do
      describe "routing" do
        it "routes to #index" do
          expect(get: "api/v1/orders").to route_to("api/v1/orders#index")
        end

        it "routes to #show" do
          expect(get: "api/v1/orders/1").to route_to("api/v1/orders#show", id: "1")
        end
      end
    end
  end
end
