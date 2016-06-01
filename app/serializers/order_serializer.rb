class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user, :created, :tip, :total, :delivery_instructions,
    :address, :meals

  def created
    object.order_date
  end

  def id
    object.order_number
  end

  def user
    {
      "phone": "+19177800565",
      "first_name": "Michael",
      "last_name": "Young",
      "user_id": 1053
    }
  end

  def tip
    1.23
  end

  def total
    123.45
  end

  def delivery_instructions
    "Something!"
  end

  def address
    {
      geolocation: "40.748585,-74.00586",
      address_line_2: "",
      zipcode: "10011",
      address: "535 west 23rd street"
    }
  end

  def meals
    [
      {
        meal_id: 123,
        name: "Triple Chocolate Brownie (x2)",
        quantity: 1
      },
      {
        meal_id: 292,
        name: "Seared Chicken Spring Succotash + Side of Rice Pilaf",
        quantity: 2
      }
    ]
  end
end
