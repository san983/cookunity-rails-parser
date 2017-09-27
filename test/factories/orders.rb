FactoryGirl.define do
  factory :order do
    address { { seamless_address: "383 Madison Avenue CONTACT YOUR MGR IF YOU DID NOT CONSUME THIS MEAL. DELIVER TO JPMC PREMISES ONLY Cross Streets: 46/47 City: New York, NY 10017 Apt/Flat/Suite/Floor #: 29 12126221127", company: "What A Company S.A.", address: "Street 123", geolocation: '40.748585,-74.00586', address_line_2: 'address line 2', zipcode: "10011" } }
    delivery_instructions "Include napkins please!!!"
    meals [{ item: "Viking Juice", price: "$10.00", quantity: 1, total: "$10.00" }, { item: "Great Hamburger", price: "$12.34", quantity: 4, total: "$24.68" }]
    order_date(Date.today - 10)
    sequence(:order_number) { |n| n }
    parsed true
    product_total 11.50
    sales_tax 1.15
    delivery_fee 2.99
    tip 2.30
    total 17.94
    sequence(:user) { |n| { name: "John #{n} Doe", first_name: "John", last_name: "Doe", phone: "(564) 839-3450" } }
    account "AccountName"

    factory :incomplete_order do
      parsed false
    end
  end
end
