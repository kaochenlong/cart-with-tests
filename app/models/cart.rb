class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(product_id)
    item = items.find { |x| x.product_id == product_id }

    if item
      item.increment
    else
      items << CartItem.new(product_id)
    end
  end

  def empty?
    items.empty?
  end
end

