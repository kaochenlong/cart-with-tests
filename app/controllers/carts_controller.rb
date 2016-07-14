class CartsController < ApplicationController
  def show
  end

  def checkout
    @order = Order.new
  end
end
