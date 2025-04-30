# frozen_string_literal: true

require_relative 'discounts'

class ShoppingCart
  attr_reader :items, :promo_discount, :discount_strategy

  PROMO_CODES = {
    'SAVE10' => 0.10,  # 10% discount
    'SAVE20' => 0.20   # 20% discount (example for future)
  }.freeze

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
    if PROMO_CODES.key?(code)
      @promo_discount = PROMO_CODES[code]
    else
      @promo_discount = 0.0
    end
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

  private

  def calculate_subtotal(prices)
    @items.sum { |item, qty| (prices[item] || 0) * qty }
  end

  def apply_promo_discount(subtotal)
    subtotal - (subtotal * @promo_discount)
  end

  def apply_additional_discounts(subtotal)
    if @discount_strategy
      @discount_strategy.apply(subtotal)
    else
      subtotal
    end
  end
end
