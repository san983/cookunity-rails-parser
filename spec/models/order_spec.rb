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
      let(:complete_orders) { FactoryGirl.create_list(:order, 2) }
      let(:draft_orders) { FactoryGirl.create_list(:incomplete_order, 2) }

      it "includes orders with parsed flag" do
        expect(Order.complete).to eq(complete_orders)
      end

      it "excludes orders without parsed flag" do
        expect(Order.complete).to_not eq(draft_orders)
      end
    end
  end
end
