# lib/shopping_cart.rb

require_relative 'discount_strategies'

class ShoppingCart
  attr_reader :items, :promo_discount, :discount_strategy

  def initialize
    @items = {}
    @promo_discount = 0.0
    @discount_strategy = nil
  end

  def add(item, quantity = 1)
    @items[item] ||= 0
    @items[item] += quantity
  end

  def remove(item)
    @items.delete(item)
  end

  def clear
    @items.clear
  end

  def apply_promo(code)
    @promo_discount = code == 'SAVE10' ? 0.10 : 0.0
  end

  def update_quantity(item, new_qty)
    raise 'Item not found' unless @items.key?(item)
    raise ArgumentError, 'Quantity must be > 0' unless new_qty.positive?

    @items[item] = new_qty
  end

  def apply_discount(discount_strategy)
    @discount_strategy = discount_strategy
  end

  def total_price(prices = {})
    subtotal = calculate_subtotal(prices)
    subtotal_after_promo = apply_promo_discount(subtotal)
    apply_additional_discounts(subtotal_after_promo).round(2)
  end

  def total_items
    @items.keys.count
  end

  def total_quantity
    @items.values.sum
  end

  private

  def calculate_subtotal(prices)
    @items.sum { |item, qty| (prices[item] || 0) * qty }
  end

  def apply_promo_discount(subtotal)
    subtotal - (subtotal * @promo_discount)
  end

  def apply_additional_discounts(subtotal)
    @discount_strategy ? @discount_strategy.apply(subtotal) : subtotal
  end
end
