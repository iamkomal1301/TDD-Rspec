require 'shopping_cart'

RSpec.describe ShoppingCart do
  it 'starts empty' do
    cart = ShoppingCart.new
    expect(cart.items).to eq({})
  end

  it 'adds a single item' do
    cart = ShoppingCart.new
    cart.add('apple', 2)
    expect(cart.items).to eq({ 'apple' => 2 })
  end

  it 'returns total number of unique items' do
    cart.add('apple', 2)
    cart.add('banana', 1)
    expect(cart.total_items).to eq(2)
  end

  it 'returns total quantity of all items' do
    cart.add('apple', 2)
    cart.add('banana', 3)
    expect(cart.total_quantity).to eq(5)
  end

  it 'removes an item completely' do
    cart.add('apple', 2)
    cart.remove('apple')
    expect(cart.items).not_to include('apple')
  end

  it 'clears all items' do
    cart.add('apple', 2)
    cart.clear
    expect(cart.items).to be_empty
  end

  it 'calculates total price' do
    cart.add('apple', 2)
    cart.add('banana', 1)
    prices = { 'apple' => 3.0, 'banana' => 2.0 }
    expect(cart.total_price(prices)).to eq(8.0)
  end

  it 'applies a 10% discount' do
    cart.add('apple', 2)
    prices = { 'apple' => 5.0 }
    expect(cart.total_price(prices, discount: 0.10)).to eq(9.0)
  end
end
