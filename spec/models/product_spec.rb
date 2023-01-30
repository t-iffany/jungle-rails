require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    # validation tests/examples here
    
    it "is valid when all four fields are set" do
      @category = Category.new(name: "newCat")      
      @product = Product.new(name: "newProd", price_cents: "1000", quantity: "25", category: @category)
      expect(@product).to be_valid
      expect(@product.errors.full_messages).to_not include("can't be blank")
    end

    it "is valid when name is set" do  
      @category = Category.new(name: "newCat")      
      @product = Product.new(name: nil, price_cents: "1000", quantity: "25", category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "is valid when price is set" do
      @category = Category.new(name: "newCat")      
      @product = Product.new(name: "testProd", price_cents: nil, quantity: "25", category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "is valid when quantity is set" do
      @category = Category.new(name: "newCat")      
      @product = Product.new(name: "testProd", price_cents: "1000", quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "is valid when category is set" do
      @category = Category.new(name: "newCat")      
      @product = Product.new(name: "testProd", price_cents: "1000", quantity: "25", category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end

end
