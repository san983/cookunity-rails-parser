class OrderSerializer < ActiveModel::Serializer
  attributes :id, :complete, :user, :created, :product_total, :sales_tax, :delivery_fee, :tip, :total, :delivery_instructions,
    :address, :meals, :failed_parsing

  def complete
    object.parsed
  end

  def error
    object.failed_parsing
  end

  def created
    object.order_date.to_formatted_s(:iso8601)
  end

  def id
    object.order_number
  end

  def user
    return {} unless object.parsed && object.user
    {
      phone: object.user[:phone],
      first_name: object.user[:first_name],
      last_name: object.user[:last_name],
      user_id: -1
    }
  end

  def tip
    object.tip.to_f
  end

  def total
    object.total.to_f
  end

  def delivery_fee
    object.delivery_fee.to_f
  end

  def sales_tax
    object.sales_tax.to_f
  end

  def product_total
    object.product_total.to_f
  end

  def delivery_instructions
    object.delivery_instructions
  end

  def address
    return {} unless object.parsed && object.address
    {
      seamless_address: object.address[:seamless_address],
      address: object.address[:address],
      address_line_2: object.address[:address_line_2],
      geolocation: object.address[:geolocation],
      zipcode: object.address[:zipcode],
      company: object.address[:company]
    }
  end

  def meals
    return {} unless object.parsed && object.meals
    object.meals.map do |meal|
      {
        meal_id: -1,
        name: meal[:item],
        quantity: meal[:quantity]
      }
    end
  end
end
