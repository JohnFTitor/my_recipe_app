class UsersController < ApplicationController
  def index
    missing_food = current_user.missing_food
    @recipe_foods = missing_food[:data]
    @total_price = missing_food[:price]
  end
end
