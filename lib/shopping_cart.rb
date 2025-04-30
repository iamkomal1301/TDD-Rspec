# frozen_string_literal: true

# lib/shopping_cart.rb
class ShoppingCart
  attr_reader :items

  def initialize
    @items = {}
    @promo_discount = 0.0
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

  def apply_promo(code)
    @promo_discount = case code
                      when 'SAVE10'
                        0.10 # Apply a 10% discount
                      else
                        0.0 # No discount for unrecognized codes
                      end
  end

  def total_price(prices = {})
    total = @items.sum { |item, qty| (prices[item] || 0) * qty }
    discount = total * @promo_discount # Apply the discount
    (total - discount).round(2) # Subtract the discount from the total and round it
  end

  def update_quantity(item, new_qty)
    raise 'Item not found' unless @items.key?(item)
    raise ArgumentError, 'Quantity must be > 0' unless new_qty.positive?

    @items[item] = new_qty
  end
end
