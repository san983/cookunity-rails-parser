require 'rails_helper'

RSpec.describe LinkInfo, type: :model do
  context 'associations' do
    it { should belong_to(:order) }
  end

  context 'validations' do
    it { should allow_value('6DCB7A86833FCD552185890FF90EC8D73C52F4CF').for(:token) }
    it { should allow_value(40_833).for(:vendor_location_id) }

    it { should validate_numericality_of(:order_id) }
    it { should validate_presence_of(:order_id) }
  end
end
