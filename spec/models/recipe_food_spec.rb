require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before :all do
    User.destroy_all
    user = FactoryBot.create :user
    recipe = create :recipe, :name, :preparation_time, :cooking_time, :description, user: user
    food = FactoryBot.build :food
    food.price = 20
    food.save
    @recipe_food = RecipeFood.create(quantity: 5, food:, recipe:)
  end

  it 'should return the total price of the recipe' do
    total_price = @recipe_food.total_price
    expect(total_price).to eq(100)
  end
end
