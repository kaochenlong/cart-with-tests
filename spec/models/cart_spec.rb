require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "購物車相關功能" do
    it "可以加到購物車" do
      cart = Cart.new
      expect(cart.empty?).to be true

      cart.add_item(1)
      expect(cart.empty?).to be false
    end

    it "加一樣的商品不會增加 item 數" do
      cart = Cart.new
      5.times do
        cart.add_item(1)
      end
      3.times do
        cart.add_item(2)
      end

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
      expect(cart.items.last.quantity).to be 3
    end
  end
end
