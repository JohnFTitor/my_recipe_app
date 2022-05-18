require 'rails_helper'

RSpec.describe 'Recipes Page', type: :feature do 
  describe 'Get Index' do
    before(:all) do
      User.destroy_all
      @user = create :user, :name, :password, :confirmed_at, email: 'user@example.com'
      create_list :recipe, 20, :name, :preparation_time, :cooking_time, :description, :public, user: @user
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

      expect(recipes.length).to eq(20) 
    end

    it 'Should lead to recipe details' do 
      id = @user.recipes.first.id

      recipe = page.find('a', id: "Recipe: #{id}")

      recipe.click

      expect(page).to have_current_path(recipe_path(id: id))
    end

    it 'Should allow users to delete its own recipes' do
      recipe_record = @user.recipes.first
      
      recipe = page.find('li', id: "recipe-card: #{recipe_record.id}")

      remove = recipe.find_button('Remove')

      remove.click

      expect(page).to_not have_content(recipe_record.name)
      expect(page).to have_content("Recipe succesfully deleted")
    end

    it 'Should allow users to create recipes' do 
      new_recipe_button = page.find_link('Add Recipe')

      new_recipe_button.click

      expect(page).to have_current_path(new_recipe_path)
    end
  end
end
