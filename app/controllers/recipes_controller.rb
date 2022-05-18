class RecipesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @recipes = current_user.get_recipes
  end

  def show
  end

  def destroy
    id = params[:id]
    Recipe.destroy(id)
    flash[:destroyed] = "Recipe succesfully deleted"
    redirect_back(fallback_location: root_path)
  end
end
