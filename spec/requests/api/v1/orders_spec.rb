require "rails_helper"

RSpec.describe "Orders API", type: :request do
  let(:orders) { FactoryGirl.create_list(:order, 2) }

  it 'retrieves a list of orders' do
    get '/api/v1/orders'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.length).to eq(Order.count)
  end

  it 'retrieves an specific of order' do
    get "/api/v1/orders/#{orders.first.order_number}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(orders.first.order_number)
  end

  it 'retrieves an specific of order' do
    get '/api/v1/orders/non-existing'

    expect(response).to be_not_found
    expect(response.body).to eq("Not Found")
  end
end
