require 'rails_helper'

RSpec.describe 'Recipes Page', type: :feature do
  describe 'Get Index' do
    before(:all) do
      User.destroy_all
      @user = FactoryBot.build :user
      @user.password = '123456'
      @user.email = 'user@example.com'
      @user.save
      create_list :recipe, 5, :name, :preparation_time, :cooking_time, :description, :public, user: @user
    end

    before :each do
      visit new_user_session_path
      fill_in('Email', with: 'user@example.com')
      fill_in('Password', with: '123456')
      click_button 'Log in'
      visit recipes_path
    end

    it 'Should load to recipes page' do
      expect(page).to have_current_path(recipes_path)
    end

    it 'Should display user own recipes' do
      recipes = page.find_all('.recipe')

      expect(recipes.length).to eq(5)
    end

    it 'Should lead to recipe details' do
      id = @user.recipes.first.id

      recipe = page.find('a', id: "Recipe: #{id}")

      recipe.click

      expect(page).to have_current_path(recipe_path(id:))
    end

    it 'Should allow users to delete its own recipes' do
      recipe_record = @user.recipes.first

      recipe = page.find('li', id: "recipe-card: #{recipe_record.id}")

      remove = recipe.find_button('Remove')

      remove.click

      expect(page).to_not have_content(recipe_record.name)
      expect(page).to have_content('Recipe succesfully deleted')
    end

    it 'Should allow users to create recipes' do
      new_recipe_button = page.find_link('Add Recipe')

      new_recipe_button.click

      expect(page).to have_current_path(new_recipe_path)
    end
  end

  describe 'Add Recipe' do
    before(:all) do
      User.destroy_all
      user = FactoryBot.build :user
      user.password = '123456'
      user.email = 'user@example.com'
      user.save
    end

    before :each do
      visit new_user_session_path
      fill_in('Email', with: 'user@example.com')
      fill_in('Password', with: '123456')
      click_button 'Log in'
      visit new_recipe_path
    end

    it 'Should contain all the fields' do
      name = find_field('Name')
      preparation_time = find_field('Preparation time')
      cooking_time = find_field('Cooking time')
      description = find_field('Description')
      public_field = find_field('Public')

      expect(name).to_not be_nil
      expect(preparation_time).to_not be_nil
      expect(cooking_time).to_not be_nil
      expect(description).to_not be_nil
      expect(public_field).to_not be_nil
    end

    it 'Should display an error message if required fields are empty' do
      click_button 'Create Recipe'

      expect(page).to have_content('Wrond Value. Please make sure you filled all inputs')
    end

    it 'Should create recipe if required fields are not empty' do
      fill_in('Name', with: 'Test')
      fill_in('Preparation time', with: 60)
      fill_in('Cooking time', with: 60)

      click_button 'Create Recipe'

      expect(page).to have_current_path(recipes_path)
      expect(page).to have_content('Recipe was succesfully created')
    end
  end

  describe 'See Public Recipes' do 
    before(:all) do
      User.destroy_all
      @user = FactoryBot.build :user
      @user.password = '123456'
      @user.email = 'user@example.com'
      @user.save
      @user2 = FactoryBot.create :user
      @user3 = FactoryBot.create :user
      @user3.name = "Don't find me"
      create_list :recipe, 10, :name, :preparation_time, :cooking_time, :description, public: true, user: @user
      create_list :recipe, 7, :name, :preparation_time, :cooking_time, :description, public: true, user: @user2
      create_list :recipe, 3, :name, :preparation_time, :cooking_time, :description, public: false, user: @user3
    end

    before(:each) do
      visit public_recipes_path
    end

    it 'should display public recipes' do 
      recipes = page.find_all('.recipe')

      expect(recipes.length).to eq(17)
    end

    it 'should contain user name in each recipe card' do 
      expect(page).to have_content("By: #{@user.name}")      
      expect(page).to have_content("By: #{@user2.name}")      
      expect(page).to_not have_content("By: #{@user3.name}")      
    end

    it 'Should lead to recipe details' do
      id = Recipe.public_recipes.first.id

      recipe = page.find('a', id: "Recipe: #{id}")

      recipe.click

      expect(page).to have_current_path(recipe_path(id:))
    end

    it 'should not be able to see remove button if not authenticated' do 
      expect(page).to_not have_content('Remove')
    end

    it 'should not be able to see remove button for other users' do
      # Authenticate first user, so it doesn't see second_user remove button
      visit new_user_session_path
      fill_in('Email', with: 'user@example.com')
      fill_in('Password', with: '123456')
      click_button 'Log in'
      visit public_recipes_path

      recipe_record = Recipe.public_recipes.where(user_id: @user2.id).limit(1)[0]
      recipe = page.find('li', id: "recipe-card: #{recipe_record.id}")

      expect(recipe).to_not have_content('Remove')
    end
 
    it 'Should allow users to delete its own recipes' do
      
      # Requires user to be logged in to see the remove button
      visit new_user_session_path
      fill_in('Email', with: 'user@example.com')
      fill_in('Password', with: '123456')
      click_button 'Log in'
      visit public_recipes_path

      recipe_record = Recipe.public_recipes.where(user_id: @user.id).limit(1)[0]
      recipe = page.find('li', id: "recipe-card: #{recipe_record.id}")
      remove = recipe.find_button('Remove')
      remove.click

      expect(page).to_not have_content(recipe_record.name)
      expect(page).to have_content('Recipe succesfully deleted')
    end

    it 'should have relevant info of its ingredients' do
      recipe_record = Recipe.public_recipes.first
      recipe = page.find('li', id: "recipe-card: #{recipe_record.id}")

      price = recipe_record.total_cost
      ingredients = recipe_record.total_ingredients

      expect(recipe).to have_content("Total price: #{price}")
      expect(recipe).to have_content("Total food items: #{ingredients}")
    end
  end
end
