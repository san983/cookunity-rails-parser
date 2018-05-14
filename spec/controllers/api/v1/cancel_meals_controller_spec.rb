require 'rails_helper'

module Api::V1
  RSpec.describe CancelMealsController, type: :controller do
    # Authentication is tested in request specs
    before(:each) { allow(controller).to receive(:authenticate) { true } }

    let(:valid_attributes) { { cancel_meal: { meal: "Soup from #{DateTime.now}" } } }

    describe "POST #create" do
      it "creates a new CancelMeal job" do
        post :create, params: valid_attributes
        expect(response.body).to eq(valid_attributes[:cancel_meal].to_json)
        expect(response).to be_successful
      end
    end
  end
end
