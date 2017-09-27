require 'rails_helper'

RSpec.describe SeamlessData, type: :model do
  it "initializes an object with defaults" do
    seamlessData = SeamlessData.new(1)

    expect(seamlessData.username).to be_kind_of(String)
    expect(seamlessData.seamless_user_id).to be_kind_of(String)
    expect(seamlessData.password).to be_kind_of(String)
    expect(seamlessData.loginUrl).to be_kind_of(String)
    expect(seamlessData.oldOrdersUrl).to be_kind_of(String)
  end
end
