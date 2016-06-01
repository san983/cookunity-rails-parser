class LinkInfo < ApplicationRecord
  belongs_to :order

  validates :order_id, presence: true
  validates_numericality_of :order_id, only_integer: true
  validates :auto_print, inclusion: { in: [true, false] }
end
