require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    describe 'confirms each attribute for a given product is present' do
      context 'product with all required attributes' do 
        before(:each) do
          @category = Category.new({ name: "uno" })
          @category.save
          @product = Product.new({ name: "p-uno", price: 2000, quantity: 30, category: @category })
          @product.save
        end
        it 'confirms the presence of name attribute' do
          expect(@product.name).to be_present
        end
        it 'confirms the presence of price attribute' do
          expect(@product.price).to be_present
        end
        it 'confirms the presence of quantity attribute' do
          expect(@product.quantity).to be_present
        end
        it 'confirms the presence of category attribute' do
          expect(@product.category).to be_present
        end
      end
      context 'product with no name attribute' do
        @category = Category.create({ name: "uno" })
        @product = Product.create({ name: nil, price: 2000, quantity: 30, category: @category })
        error = @product.errors.full_messages
        it "returns 'Name can't be blank'" do
          expect(error).to include("Name can't be blank")
        end
      end
      context 'product with no price attribute' do
        @category = Category.create({ name: "uno" })
        @product = Product.create({ name: "p-uno", quantity: 30, category: @category })
        error = @product.errors.full_messages
        
        it "returns 'Price can't be blank'" do
          expect(error).to include("Price can't be blank")
        end
      end
      context 'product with no quantity attribute' do
        @category = Category.create({ name: "uno" })
        @product = Product.create({ name: "p-uno", price: 2000, quantity: nil, category: @category })
        error = @product.errors.full_messages
        it "returns 'Quantity can't be blank'" do
          expect(error).to include("Quantity can't be blank")
        end
      end
      context 'product with no category attribute' do
        @product = Product.create({ name: "p-uno", price: nil, quantity: 30, category: nil })
        error = @product.errors.full_messages
        it "returns 'Category can't be blank'" do
          expect(error).to include("Category can't be blank")
        end
      end
    end  
  end
end