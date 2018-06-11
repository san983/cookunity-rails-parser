class Order < ApplicationRecord
  validates :failed_parsing, inclusion: { in: [true, false] }
  validates :order_date, :order_number, presence: true
  validates_numericality_of :order_number, only_integer: true

  serialize :address
  serialize :meals
  serialize :user

  has_one :link_info, dependent: :destroy

  scope :complete, -> { where(parsed: true) }

  # We need to focus just in NY timezone for defining the "today" scope
  scope :from_today, lambda {
    Time.zone = "Eastern Time (US & Canada)"
    where(order_date: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  }

  # We need to focus just in NY timezone for defining the "date" scope
  scope :from_date, lambda { |date_in_string|
    Time.zone = "Eastern Time (US & Canada)"
    date = Time.zone.parse(date_in_string)
    where(order_date: date.beginning_of_day..date.end_of_day)
  }
end
