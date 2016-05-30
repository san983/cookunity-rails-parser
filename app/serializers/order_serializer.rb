class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :user
end
