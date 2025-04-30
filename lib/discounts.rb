# lib/discount_strategy.rb

class DiscountStrategy
  def apply(subtotal)
    raise NotImplementedError, 'Subclasses must implement the apply method'
  end
end
