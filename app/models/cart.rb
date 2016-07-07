class CartItem
end

class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(product_id)
    # 找： item = 找 item
    item = @items.find { |x| x.product_id == product_id }

    # if 有一樣的
    if item
      item.increment
    else
      @items << CartItem.new(product_id)
    end

    #   item.quantity += 1
    # else
    #   @items < new item

    #@items << product
  end

  def empty?
    @items.empty?
  end
end

