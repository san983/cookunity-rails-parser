class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :user, :order_date
end
