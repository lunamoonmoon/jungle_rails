require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Plushies')
      @product = Product.new(
        name: 'Cinnamaroll',
        category: @category,
        quantity: 100,
        price: 50.00
      )
    end

    it "saves successfully" do
      #  ensures that a product with all four fields set will indeed save successfully
      expect(@product.save).to be true
    end

    it "includes a name" do
      # violate the validation rule
      @product.name = nil
      # attempt to save
      @product.save
      # check error message is correct
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "includes a price" do
      @product.price = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "includes a quantity" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "includes a category" do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
