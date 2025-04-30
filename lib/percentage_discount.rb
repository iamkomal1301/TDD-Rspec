# lib/percentage_discount.rb

require_relative 'discount_strategy'

class PercentageDiscount < DiscountStrategy
  def initialize(percent)
    @percent = validate_percentage(percent)
  end

  def apply(subtotal)
    subtotal - (subtotal * (@percent / 100.0))
  end

  private

  def validate_percentage(percent)
    raise ArgumentError, 'Percentage must be between 0 and 100' unless percent.between?(0, 100)
    percent
  end
end
