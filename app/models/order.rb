class Order < ApplicationRecord
  has_many :order_items

  validates :address, presence: true
end
