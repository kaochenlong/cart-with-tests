class Api::V1::Pay2goController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callback]

  def callback
    raw = JSON.parse(params["JSONData"])
    result = JSON.parse(raw["Result"])
    trade_number = result["TradeNo"]
    check_code = result["CheckCode"]
    order_id = result["MerchantOrderNo"].to_i

    order = Order.find_by(id: order_id)

    pay2go = Pay2go::Service.new

    if check_code == pay2go.valid_check_code(order, trade_number)
      render text: "ok"
    else
      fail
    end
  end

  private

end
