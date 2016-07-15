require "digest"

module Pay2go
  class Service
    attr_reader :merchant_id

    def initialize
      @hash_key = "uFcODjQdsQDPnxnTMIcPX5TpqON8Xk4r"
      @hash_iv = "ZhgCA7Q3XuTk2gdO"
      @merchant_id = "32237946"
    end

    def check_value(order)
      fields_string = {
        Amt: order.amount,
        MerchantID: @merchant_id,
        MerchantOrderNo: order.id,
        TimeStamp: order.created_at.to_i,
        Version: "1.2"
      }.sort.map { |k, v| "#{k}=#{v}" }.join("&")

      Digest::SHA256.hexdigest("HashKey=#{@hash_key}&#{fields_string}&HashIV=#{@hash_iv}").upcase
    end

    def valid_check_code(order, trading_number)
      fields_string = {
        Amt: order.amount,
        MerchantID: merchant_id,
        MerchantOrderNo: order.id,
        TradeNo: trading_number
      }.sort.map { |k, v| "#{k}=#{v}" }.join("&")

      Digest::SHA256.hexdigest("HashIV=#{@hash_iv}&#{fields_string}&HashKey=#{@hash_key}").upcase
    end

  end
end
