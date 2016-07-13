class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
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

  def total_price
    items.reduce(0) { |sum, item| sum + item.total_price }
  end

  def serialize
    result = items.map { |item| {"product_id" => item.product_id,
                                 "quantity" => item.quantity} }
    { "items" => result }
  end

  def self.build_from_hash(hash)
    all_items = []
    if hash && hash["items"]
      all_items = hash["items"].map do |item|
        CartItem.new(item["product_id"], item["quantity"])
      end
    end
    new all_items
  end
end

