require 'rails_helper'

RSpec.describe "CancelMeals API", type: :request do

  let(:headers) { { "CONTENT_TYPE" => "application/json" } }

  context 'without a token' do
    describe "POST api/v1/cancel_meals" do
      it "responds unauthorized" do
        post "/api/v1/cancel_meals"
        expect(response).to be_unauthorized
      end
    end
  end

  context 'with an invalid token' do
    let(:invalid_auth_token) do
      { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials('invalid-token') }
    end

    describe "POST api/v1/cancel_meals" do
      it "responds unauthorized" do
        post "/api/v1/cancel_meals", env: invalid_auth_token
        expect(response).to be_unauthorized
      end
    end
  end

  context 'with an valid token' do

    let(:valid_auth_token) do
      { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(Rails.application.secrets.api_token) }
    end

    let(:headers) do
      { "ACCEPT" => "application/json" }
    end

    describe "POST api/v1/cancel_meals" do
      it "responds a job id" do
        post "/api/v1/cancel_meals", params: { cancel_meal: { meal: "Soup" } }, headers: headers, env: valid_auth_token

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:created)
      end
    end
  end
end
