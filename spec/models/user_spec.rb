require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject { User.new(name: 'Something') }

    it 'should require name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Methods' do
    before(:all) do
      User.destroy_all
      @user = FactoryBot.create :user
      user2 = FactoryBot.create :user
      create_list :recipe, 5, :name, :preparation_time, :cooking_time, :description, :public, user: @user
      create_list :recipe, 5, :name, :preparation_time, :cooking_time, :description, :public, user: @user
      recipe = create :recipe, :preparation_time, :cooking_time, :description, public: false, user: @user, name: 'last_added'
      @total_price = 0

      (1..5).each do
        food = FactoryBot.build :food
        food.user = @user
        food.save
        RecipeFood.create(quantity: 3, recipe: recipe, food:)
      end

      (1..5).each do
        food = FactoryBot.build :food
        food.user = user2
        food.save
        RecipeFood.create(quantity: 3, recipe: recipe, food:)
        @total_price += food.price * 3
      end
    end

    it 'should return true for default users' do
      expect(@user.chef?).to be true
    end

    it 'should return all recipes ordered by creation' do
      recipes = @user.fetch_recipes

      last_added_name = recipes.first.name

      expect(recipes.length).to eq(11)
      expect(last_added_name).to eq('last_added')
    end

    it 'should return all missing food for all recipes of the user' do 
      missing_food = @user.missing_food

      expect(missing_food[:data].length).to eq(5)
    end

    it 'should return the total cost of the missing food' do 
      missing_food = @user.missing_food

      expect(missing_food[:price]).to eq(@total_price)
    end
  end
end
