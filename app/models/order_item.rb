class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_price
    product.price * quantity
  end
end
