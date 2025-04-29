require 'shopping_cart'

RSpec.describe ShoppingCart do
  it 'starts empty' do
    cart = ShoppingCart.new
    expect(cart.items).to eq({})
  end
end
