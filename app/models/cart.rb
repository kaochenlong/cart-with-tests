class Cart
  def initialize
    @items = []
  end

  def add_item(product)
    @items << product
  end

  def empty?
    @items.empty?
  end
end

