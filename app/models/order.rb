class Order < ApplicationRecord
  # relations
  has_many :order_items

  # validations
  validates :address, presence: true

  # instance methods
  def serial_generator
    "OD#{id.to_s.rjust(10, "0")}"
  end

  def amount
    order_items.reduce(0) { |sum, item| sum + item.total_price }
  end
end
