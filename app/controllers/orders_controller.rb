class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)

    @cart.items.each do |item|
      @order.order_items.build(product_id: item.product.id, quantity: item.quantity)
    end

    if @order.save
      # 1. 清空購物車
      session["my_cart_session_123"] = nil

      # 2. 轉往智付寶
      redirect_to pay_order_path(@order)
    else
      render "carts/checkout"
    end
  end

  def pay
    hash_key = "uFcODjQdsQDPnxnTMIcPX5TpqON8Xk4r"
    hash_iv = "ZhgCA7Q3XuTk2gdO"
    @order = Order.find_by(id: params[:id])
    redirect_to root_path unless @order
  end

  private

  def order_params
    params.require(:order).permit(:name, :tel, :address)
  end
end
