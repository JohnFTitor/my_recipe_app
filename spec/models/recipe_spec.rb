require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :all do
    User.destroy_all
    @user = FactoryBot.create :user
  end

  subject { create :recipe, :name, :preparation_time, :cooking_time, :public, user: @user }

  context 'Validations' do 
    it 'should have a name attribute' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  
    it 'should have a preparation time' do
      subject.preparation_time = nil
      expect(subject).to_not be_valid
    end
  
    it 'should have a cooking time' do
      subject.cooking_time = nil
      expect(subject).to_not be_valid
    end
  
    it 'should have an user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end
  
    it 'should be valid without description' do
      subject.description = ''
      expect(subject).to be_valid
    end
  end

  context 'Methods' do 
    before :all do 
      @recipe = create :recipe, :name, :preparation_time, :cooking_time, :public, user: @user

      @total_price = 0

      (1..20).each do
        food = FactoryBot.create :food 
        RecipeFood.create( quantity: 1, recipe: @recipe, food: food)
        @total_price += food.price 
      end
    end

    
    it 'should return the price of all its food' do 
      total_price = @recipe.total_cost

      expect(total_price).to eq(@total_price)
    end

    it 'should return the quantity of igrendients it has' do 
      total_ingredients = @recipe.total_ingredients

      expect(total_ingredients).to eq(20)
    end
  end

end
