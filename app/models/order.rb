class Order < ApplicationRecord
  validates :order_number, presence: true
  validates_numericality_of :order_number, only_integer: true
end
