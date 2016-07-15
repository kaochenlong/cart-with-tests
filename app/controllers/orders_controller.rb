class OrdersController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:finish]

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
    @order = Order.find_by(id: params[:id])
    redirect_to root_path unless @order

    pay2go = Pay2go::Service.new

    @merchant_id = pay2go.merchant_id
    @return_url = finish_orders_url
    @notify_url = api_v1_pay2go_callback_url
    @check_value = pay2go.check_value(@order)
  end

  def finish
    render text: "finish"
  end

  private

  def order_params
    params.require(:order).permit(:name, :tel, :address)
  end

end
