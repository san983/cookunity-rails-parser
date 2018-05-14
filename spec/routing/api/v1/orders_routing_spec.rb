require "rails_helper"

module Api::V1
  RSpec.describe OrdersController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "api/v1/orders").to route_to("api/v1/orders#index")
      end

      it "routes to #index with date param" do
        expect(get: "api/v1/orders?date=2016-04-06").to route_to("api/v1/orders#index", date: '2016-04-06')
      end

      it "routes to #show" do
        expect(get: "api/v1/orders/1").to route_to("api/v1/orders#show", id: "1")
      end
    end
  end
end
