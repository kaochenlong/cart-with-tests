class Api::V1::Pay2goController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callback]

  def callback
    raw = JSON.parse(params["JSONData"])
    result = JSON.parse(raw["Result"])
    trade_number = result["TradeNo"]
    check_code = result["CheckCode"]
    order_id = result["MerchantOrderNo"].to_i

    order = Order.find_by(id: order_id)

    if check_code == valid_check_code(order, trade_number)
      render text: "ok"
    else
      fail
    end
  end

  private

  def valid_check_code(order, trading_number)
    hash_key = "uFcODjQdsQDPnxnTMIcPX5TpqON8Xk4r"
    hash_iv = "ZhgCA7Q3XuTk2gdO"
    fields_string = {
      Amt: order.amount,
      MerchantID: "32237946",
      MerchantOrderNo: order.id,
      TradeNo: trading_number
    }.sort.map { |k, v| "#{k}=#{v}" }.join("&")

    Digest::SHA256.hexdigest("HashIV=#{hash_iv}&#{fields_string}&HashKey=#{hash_key}").upcase
  end
end
