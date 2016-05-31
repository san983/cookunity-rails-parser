require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validations' do
    it { should validate_presence_of(:order_number) }
    it { should validate_numericality_of(:order_number).only_integer }
  end
end
