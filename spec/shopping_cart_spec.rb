# spec/shopping_cart_spec.rb

require_relative '../lib/shopping_cart'
require_relative '../lib/discount_strategy'
require_relative '../lib/percentage_discount'
require_relative '../lib/fixed_discount'

RSpec.describe ShoppingCart do
  let(:cart) { ShoppingCart.new }
  let(:prices) { { 'apple' => 5.0, 'banana' => 2.0 } }

  context 'when the cart is empty' do
    it 'starts empty' do
      expect(cart.items).to eq({})
    end
  end

  context 'when adding items' do
    it 'adds a single item' do
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
  end

  context 'when clearing the cart' do
    it 'clears all items' do
      cart.add('apple', 2)
      cart.clear
      expect(cart.items).to be_empty
    end
  end

  context 'when calculating total price' do
    it 'calculates total price of items' do
      cart.add('apple', 2)
      cart.add('banana', 1)
      expect(cart.total_price(prices)).to eq(12.0) # corrected from 8.0
    end
  end

  context 'when applying promo codes' do
    it 'applies a 10% discount for valid promo code' do
      cart.add('apple', 2)
      cart.apply_promo('SAVE10')
      expected_price = (2 * 5.0) - ((2 * 5.0) * 0.10)
      expect(cart.total_price(prices)).to eq(expected_price)
    end

    it 'does not apply a discount for an unrecognized promo code' do
      cart.add('apple', 2)
      cart.apply_promo('INVALIDCODE')
      expected_price = 2 * 5.0
      expect(cart.total_price(prices)).to eq(expected_price)
    end
  end

  context 'when updating item quantity' do
    it 'updates quantity of an existing item' do
      cart.add('apple', 2)
      cart.update_quantity('apple', 5)
      expect(cart.items['apple']).to eq(5)
    end

    it 'raises error when updating a non-existent item' do
      expect { cart.update_quantity('banana', 3) }.to raise_error('Item not found')
    end
  end

  context 'when applying discounts via strategy' do
    it 'applies a percentage discount' do
      cart.add('apple', 2)
      discount = PercentageDiscount.new(20)
      cart.apply_discount(discount)
      expect(cart.total_price(prices)).to eq(8.0) # corrected from 16.0
    end

    it 'applies a fixed amount discount' do
      cart.add('banana', 2)
      discount = FixedDiscount.new(3)
      cart.apply_discount(discount)
      expect(cart.total_price(prices)).to eq(1.0) # corrected from 7.0
    end
  end
end
