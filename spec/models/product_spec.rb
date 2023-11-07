require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Electronics')
      @product = Product.new(
        name: 'Laptop',
        price: 999.99,
        quantity: 10,
        category: @category
      )
    end

    it 'should save successfully with all fields set' do
      expect(@product.save).to be true
    end

    it 'should validate presence of name' do
      @product.name = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should validate presence of price' do
      @product.price_cents = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should validate presence of quantity' do
      @product.quantity = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should validate presence of category' do
      @product.category = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
