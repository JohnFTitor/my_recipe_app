class RecipeFoodsController < ApplicationController
  def create
    food = Food.find_by(name: recipe_foods_params[:ingredient])
    recipe = Recipe.find(recipe_foods_params[:recipe])
    ingredient = RecipeFood.new(food:, recipe:, quantity: recipe_foods_params[:quantity])

    if ingredient.save
      flash[:success] = 'Ingredient item has been created'
    else
      flash[:alert] = 'Ingredient item could not be saved'
    end
    redirect_back fallback_location: '/'
  end

  def destroy
    respond_to do |format|
      format.html do
        if RecipeFood.find(params[:id]).destroy
          flash[:success] = 'Recipe food has been deleted'
        else
          flash[:alert] = 'Recipe food could not be deleted'
        end
        redirect_back fallback_location: '/'
      end
    end
  end

  private

  def recipe_foods_params
    params.require(:ingredient).permit(:ingredient, :quantity, :recipe)
  end
end
