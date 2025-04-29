# spec/shopping_cart_spec.rb
require 'shopping_cart'

RSpec.describe ShoppingCart do
  it 'initializes with empty cart' do
    cart = ShoppingCart.new
    expect(cart.total).to eq(0)
  end
end
