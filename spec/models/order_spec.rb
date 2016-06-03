require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'associations' do
    it { should have_one(:link_info).dependent(:destroy) }
  end

  context 'validations' do
    it { should allow_value(123).for(:order_number) }
    it { should allow_value(DateTime.now).for(:order_date) }

    it { should validate_numericality_of(:order_number).only_integer }

    it { should validate_presence_of(:order_date) }
    it { should validate_presence_of(:order_number) }
  end

  context 'scopes' do
    describe Order, ".complete" do
      let(:complete_orders) { create_list(:order, 2) }
      let(:draft_orders) { create_list(:incomplete_order, 2) }

      it "includes orders with parsed flag" do
        expect(Order.complete).to eq(complete_orders)
      end

      it "excludes orders without parsed flag" do
        expect(Order.complete).to_not eq(draft_orders)
      end
    end

    describe Order, ".from_today" do
      let(:today_order) { create(:order, created_at: Time.zone.now) }
      let(:past_order) { create(:order, created_at: 1.day.ago) }
      let(:future_order) { create(:order, created_at: 1.day.from_now) }

      it "includes orders from today" do
        expect(Order.from_today).to eq([today_order])
      end

      it "excludes orders that are not from today" do
        expect(Order.from_today).to_not include([past_order, future_order])
      end
    end
  end
end
