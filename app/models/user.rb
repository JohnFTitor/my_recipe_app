class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :recipes, dependent: :destroy
  has_many :foods, dependent: :destroy

  validates :name, presence: true

  # Internal: Retrieves recipes entries for the user in descending order.
  #
  # No Parameters.
  #
  # Returns the array of recipes.

  def fetch_recipes
    recipes.order(created_at: :desc)
  end

  def missing_food 
    user_recipes = recipes.includes(:foods)

    missing_food = []
    
    user_recipes.each do |recipe|
      missing_food.push(*recipe.foods.where.not(id: foods.ids))
    end

    price = calculate_missing_price(missing_food)
    
    return { data: missing_food, price: price}
  end

  # Internal: Checks the value inside the role attribute.
  #
  # No parameters.
  #
  # Returns true if the user's role is chef.

  def chef?
    role == 'chef'
  end

  private
  
  def calculate_missing_price(missing_food)
    recipe_foods = []

    missing_food.each do |missing_ingredient|
      recipe_foods.push(RecipeFood.find_by(food_id: missing_ingredient.id))
    end

    total_price = 0

    recipe_foods.each do |recipe_food| 
      total_price += recipe_food.total_price
    end

    total_price
  end
end
