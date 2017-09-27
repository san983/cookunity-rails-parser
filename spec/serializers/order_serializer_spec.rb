require 'rails_helper'

RSpec.describe OrderSerializer, type: :serializer do
  let(:order) { build(:order) }
  let(:serializer) { OrderSerializer.new(order) }

  it 'creates a serializer' do
    expect(serializer).to_not be_nil
  end

  it 'serializes the parsed & failed_parsing fields' do
    expect(serializer.complete).to eq order.parsed
    expect(serializer.error).to eq order.failed_parsing
  end

  it 'serializes the id, complete, account & delivery_instructions' do
    expect(serializer.id).to eq order.order_number
    expect(serializer.complete).to eq order.parsed
    expect(serializer.delivery_instructions).to eq order.delivery_instructions
    expect(serializer.account).to eq order.account
  end

  it 'serializes created data to ISO8601' do
    expect(serializer.created.to_s).to eq order.order_date.to_formatted_s(:iso8601).to_s
  end

  it 'serializes address data' do
    expected = {
      zipcode: order.address[:zipcode],
      address_line_2: order.address[:address_line_2],
      geolocation: order.address[:geolocation],
      address: order.address[:address],
      company: order.address[:company],
      seamless_address: order.address[:seamless_address]
    }
    expect(serializer.address).to eq expected
  end

  it 'serializes user data' do
    expected = {
      user_id: -1,
      phone: "(564) 839-3450",
      first_name: "John",
      last_name: "Doe"
    }
    expect(serializer.user).to eq expected
  end

  it 'serializes amounts' do
    expect(serializer.tip).to be_a(Float)
    expect(serializer.tip).to eq order.tip

    expect(serializer.total).to be_a(Float)
    expect(serializer.total).to eq order.total

    expect(serializer.delivery_fee).to be_a(Float)
    expect(serializer.delivery_fee).to eq order.delivery_fee

    expect(serializer.sales_tax).to be_a(Float)
    expect(serializer.sales_tax).to eq order.sales_tax

    expect(serializer.product_total).to be_a(Float)
    expect(serializer.product_total).to eq order.product_total
  end

  it 'serializes the meals' do
    expected = [
      {
        "meal_id": -1,
        "name": "Viking Juice",
        "quantity": 1
      }, {
        "meal_id": -1,
        "name": "Great Hamburger",
        "quantity": 4
      }
    ]
    expect(serializer.meals).to eq expected
  end
end
