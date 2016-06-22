require 'rails_helper'

module Api
  module V1
    RSpec.describe OrdersController, type: :controller do
      # Authentication is tested in request specs
      before(:each) { allow(controller).to receive(:authenticate) { true } }

      describe "GET #index" do
        it "returns http success" do
          get :index
          expect(response).to have_http_status(:success)
        end

        it "returns http success with date param" do
          get :index, params: { date: DateTime.now.strftime('%F') }
          expect(response).to have_http_status(:success)
        end
      end

      describe "GET #show" do
        it "returns http not found" do
          get :show, params: { id: 1 }

          expect(response).to have_http_status(:not_found)
        end

        it "returns http success" do
          allow(Order).to receive(:find_by_order_number).with('1')
            .and_return(Object.new)

          get :show, params: { id: 1 }

          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
