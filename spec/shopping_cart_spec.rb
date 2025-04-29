# frozen_string_literal: true

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
    cart = ShoppingCart.new
    cart.add('apple', 2)
    cart.add('banana', 1)
    expect(cart.total_items).to eq(2)
  end

  it 'returns total quantity of all items' do
    cart = ShoppingCart.new
    cart.add('apple', 2)
    cart.add('banana', 3)
    expect(cart.total_quantity).to eq(5)
  end

  it 'removes an item completely' do
    cart = ShoppingCart.new
    cart.add('apple', 2)
    cart.remove('apple')
    expect(cart.items).not_to include('apple')
  end

  it 'clears all items' do
    cart = ShoppingCart.new
    cart.add('apple', 2)
    cart.clear
    expect(cart.items).to be_empty
  end

  it 'calculates total price' do
    cart = ShoppingCart.new
    cart.add('apple', 2)
    cart.add('banana', 1)
    prices = { 'apple' => 3.0, 'banana' => 2.0 }
    expect(cart.total_price(prices)).to eq(8.0)
  end

  it 'applies a 10% discount' do
    cart = ShoppingCart.new
    cart.add('apple', 2)
    prices = { 'apple' => 5.0 }

    cart.apply_promo('SAVE10')

    expected_price = (2 * 5.0) - ((2 * 5.0) * 0.10)

    expect(cart.total_price(prices)).to eq(expected_price)
  end

  it 'does not apply a discount for an unrecognized promo code' do
    cart = ShoppingCart.new
    cart.add('apple', 2)
    prices = { 'apple' => 5.0 }
    cart.apply_promo('INVALIDCODE')

    expected_price = 2 * 5.0
    expect(cart.total_price(prices)).to eq(expected_price)
  end
end
