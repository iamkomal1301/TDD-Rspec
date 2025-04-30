# lib/fixed_discount.rb
require_relative 'discount_strategy'

class FixedDiscount < DiscountStrategy
  def initialize(amount)
    @amount = validate_amount(amount)
  end

  def apply(subtotal)
    [subtotal - @amount, 0].max
  end

  private

  def validate_amount(amount)
    raise ArgumentError, 'Discount amount must be non-negative' if amount.negative?
    amount
  end
end
