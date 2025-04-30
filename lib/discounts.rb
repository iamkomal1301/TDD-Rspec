# lib/discounts.rb

class DiscountStrategy
  def apply(subtotal)
    raise NotImplementedError, 'Subclasses must implement the apply method'
  end
end

class PercentageDiscount < DiscountStrategy
  def initialize(percent)
    @percent = percent
  end

  def apply(subtotal)
    subtotal - (subtotal * (@percent / 100.0))
  end
end

class FixedDiscount < DiscountStrategy
  def initialize(amount)
    @amount = amount
  end

  def apply(subtotal)
    [subtotal - @amount, 0].max
  end
end
