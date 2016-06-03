require "rails_helper"

RSpec.describe "Orders API", type: :request do
  let!(:complete_orders) { FactoryGirl.create_list(:order, 2) }
  let!(:draft_orders) { FactoryGirl.create_list(:incomplete_order, 2) }

  context 'without a token' do
    describe 'GET /api/v1/orders' do
      it 'retrieves a list of orders' do
        get "/api/v1/orders"
        expect(response).to be_unauthorized
      end
    end

    describe 'GET /api/v1/orders/1' do
      it 'retrieves an specific of order' do
        get "/api/v1/orders/1"
        expect(response).to be_unauthorized
      end
    end
  end

  context 'with an invalid token' do
    let(:invalid_auth_token) do
      { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials('invalid-token') }
    end

    describe 'GET /api/v1/orders' do
      it 'retrieves a list of orders' do
        get "/api/v1/orders", env: invalid_auth_token
        expect(response).to be_unauthorized
      end
    end

    describe 'GET /api/v1/orders/1' do
      it 'retrieves an specific of order' do
        get "/api/v1/orders/1", env: invalid_auth_token
        expect(response).to be_unauthorized
      end
    end
  end

  context 'with a valid token' do
    let(:valid_auth_token) do
      { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(Rails.application.secrets.api_token) }
    end

    it 'retrieves a list of complete orders' do
      get '/api/v1/orders', env: valid_auth_token

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.length).to eq(complete_orders.count)

      expected = complete_orders.map { |x| OrderSerializer.new(x) }
      expect(response.body).to eq(expected.to_json)
    end

    it 'retrieves an specific of order' do
      order = complete_orders.first

      get "/api/v1/orders/#{order.order_number}", env: valid_auth_token

      expect(response).to be_success

      expected = OrderSerializer.new(order)
      expect(response.body).to eq(expected.to_json)
    end

    it 'retrieves an specific of order' do
      get '/api/v1/orders/non-existing', env: valid_auth_token

      expect(response).to be_not_found
      expect(response.body).to eq("Not Found")
    end
  end
end
