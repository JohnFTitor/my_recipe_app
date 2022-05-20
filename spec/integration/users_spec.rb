require 'rails_helper'

RSpec.describe 'Recipes Page', type: :feature do
  describe 'Get Index' do
    before(:all) do
      User.destroy_all
      user = FactoryBot.build :user
      user.password = '123456'
      user.email = 'user@example.com'
      user.save
      user2 = FactoryBot.create :user
      @recipe = create :recipe, :preparation_time, :cooking_time, :description, public: false, user: user,
                                                                                name: 'last_added'
      @total_price = 0

      (1..10).each do |i|
        food = FactoryBot.build :food
        food.user = i <= 5 ? user : user2
        food.save
        RecipeFood.create(quantity: 3, recipe: @recipe, food:)

        next unless i > 5

        @total_price += food.price * 3
      end
    end

    before :each do
      visit new_user_session_path
      fill_in('Email', with: 'user@example.com')
      fill_in('Password', with: '123456')
      click_button 'Log in'
      visit shopping_list_path
    end

    it 'should show the amount of food missing' do
      expect(page).to have_content('Amount of food items to buy: 5')
    end

    it 'should show the total cost of all the missing food' do
      expect(page).to have_content("Total value of food needed: $#{@total_price}")
    end

    it 'should have a table with all the missing food records' do
      missing_food = page.find_all('.ingredient')

      expect(missing_food.length).to eq(5)
    end

    it 'should have the price for each of the missing food' do
      recipe_foods = @recipe.recipe_foods

      recipe_foods.each_with_index do |recipe_food, index|
        next if index < 5

        expect(page).to have_content(recipe_food.total_price)
      end
    end

    it 'should have the quantity for each of the missing food' do
      recipe_foods = @recipe.recipe_foods

      recipe_foods.each_with_index do |recipe_food, index|
        next if index < 5

        expect(page).to have_content("#{recipe_food.quantity} #{recipe_food.food.measurement_unit}")
      end
    end

    it 'should have the name for each of the missing food' do
      recipe_foods = @recipe.recipe_foods

      recipe_foods.each_with_index do |recipe_food, index|
        next if index < 5

        expect(page).to have_content(recipe_food.food.name)
      end
    end
  end
end
