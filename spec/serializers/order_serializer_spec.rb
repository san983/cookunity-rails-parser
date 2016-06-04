require 'rails_helper'

RSpec.describe OrderSerializer, type: :serializer do
  let(:order) { build(:order) }
  let(:serializer) { OrderSerializer.new(order) }

  it 'creates a serializer' do
    expect(serializer).to_not be_nil
  end

  it 'serializes the right data' do
    expect(serializer.id).to eq order.order_number
    expect(serializer.complete).to eq order.parsed
    expect(serializer.created).to eq order.order_date
  end
end
