class ShoppingCart
  attr_reader :items

  def initialize
    @items = {}
  end

  def add(item, quantity = 1)
    @items[item] ||= 0
    @items[item] += quantity
  end

  def total_items
    @items.keys.count
  end

  def total_quantity
    @items.values.sum
  end

  def remove(item)
    @items.delete(item)
  end

  def clear
    @items.clear
  end

  def total_price(prices = {}, discount: 0)
    total = @items.sum { |item, qty| (prices[item] || 0) * qty }
    total -= total * discount
    total.round(2)
  end
end
