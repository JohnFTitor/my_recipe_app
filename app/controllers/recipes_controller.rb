class RecipesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: } }
    end
  end

  def index
    @recipes = current_user.get_recipes
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.user = current_user
    respond_to do |format|
      format.html do 
        if recipe.save
          flash[:success] = 'Recipe was succesfully created'
          redirect_to action: :index
        else 
          flash.now[:error] = 'Wrond Value. Please make sure you filled all inputs'
          render :new, status: 422, locals: { recipe: }
        end
      end
    end
  end

  def show
  end

  def destroy
    id = params[:id]
    Recipe.destroy(id)
    flash[:destroyed] = "Recipe succesfully deleted"
    redirect_back(fallback_location: root_path)
  end

  private

  # Internal: Define strong parameters for recipe creation.
  #
  # Retrieves values from the form and converts string data type to integer for 
  # preparation_time and cooking_time properties, since the database requires it for
  # its instantiation.
  #
  # No examples
  #
  # Returns a hash of parameters

  def recipe_params
    response = params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
    response[:preparation_time] = response[:preparation_time].to_i
    response[:cooking_time] = response[:cooking_time].to_i
    response
  end
end
