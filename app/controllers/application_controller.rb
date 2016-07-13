class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart

  private

  def set_cart
    @cart = Cart.build_from_hash(session["my_cart_session_123"])
  end
end
