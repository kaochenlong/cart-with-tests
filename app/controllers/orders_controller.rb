require "digest"

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

    @merchant_id = "32237946"
    @return_url = finish_orders_url
    @notify_url = api_v1_pay2go_callback_url
    @check_value = check_value(@order)
  end

  def finish
    render text: "finish"
  end

  private

  def order_params
    params.require(:order).permit(:name, :tel, :address)
  end

  def check_value(order)
    hash_key = "uFcODjQdsQDPnxnTMIcPX5TpqON8Xk4r"
    hash_iv = "ZhgCA7Q3XuTk2gdO"
    fields_string = {
      Amt: order.amount,
      MerchantID: @merchant_id,
      MerchantOrderNo: order.id,
      TimeStamp: order.created_at.to_i,
      Version: "1.2"
    }.sort.map { |k, v| "#{k}=#{v}" }.join("&")

    Digest::SHA256.hexdigest("HashKey=#{hash_key}&#{fields_string}&HashIV=#{hash_iv}").upcase
  end

end
