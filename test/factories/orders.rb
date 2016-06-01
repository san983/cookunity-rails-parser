FactoryGirl.define do
  factory :order do
    sequence(:user) { |n| "User #{n}" }
    sequence(:order_number) { |n| n }
    order_date  (Date.today - 10)
  end
end
