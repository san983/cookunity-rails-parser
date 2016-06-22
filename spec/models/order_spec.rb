require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'associations' do
    it { should have_one(:link_info).dependent(:destroy) }
  end

  context 'validations' do
    it { should allow_value(123).for(:order_number) }
    it { should allow_value(DateTime.now).for(:order_date) }

    it { should validate_inclusion_of(:failed_parsing).in?([false, true]) }

    it { should validate_numericality_of(:order_number).only_integer }

    it { should validate_presence_of(:order_date) }
    it { should validate_presence_of(:order_number) }

    it { should serialize(:address) }
    it { should serialize(:meals) }
    it { should serialize(:user) }
  end

  context 'db columns' do
    it { should have_db_column(:address).of_type(:text) }
    it { should have_db_column(:delivery_fee).of_type(:decimal) }
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:meals).of_type(:text) }
    it { should have_db_column(:order_date).of_type(:datetime) }
    it { should have_db_column(:order_number).of_type(:integer) }
    it { should have_db_column(:parsed).of_type(:boolean) }
    it { should have_db_column(:product_total).of_type(:decimal) }
    it { should have_db_column(:sales_tax).of_type(:decimal) }
    it { should have_db_column(:tip).of_type(:decimal) }
    it { should have_db_column(:total).of_type(:decimal) }
    it { should have_db_column(:user).of_type(:text) }
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
