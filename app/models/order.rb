class Order < ApplicationRecord
  validates :failed_parsing, inclusion: { in: [true, false] }
  validates :order_date, :order_number, presence: true
  validates_numericality_of :order_number, only_integer: true

  serialize :address
  serialize :meals
  serialize :user

  has_one :link_info, dependent: :destroy

  scope :complete, -> { where(parsed: true) }

  scope :from_today, -> {
    # We need to focus just in NY timezone for defining the "today" scope
    Time.zone = "Eastern Time (US & Canada)"
    where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  }
end
