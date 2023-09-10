class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  # Internal: Retrieves the recipe_foods records for all the missing food elements.
  #
  # Uses a MINUS Query to get all the recipe_foods records where the ids are not found in
  # the user foods. Additionally, uses the include statement to prepare the :food relation
  # in the recipe_food. This process is made through each recipe owned by the user, being added
  # to an array called missing_food. Finally, uses the helper function to calculate the price,
  # and returns a hash with the data and the total price.
  #
  # No Parameters.
  #
  # Returns an hash with an array and an integer.

  def missing_food
    user_recipes = recipes.includes(:recipe_foods)

    missing_food = []

    user_recipes.each do |recipe|
      missing_food.push(*recipe.recipe_foods.where.not(food_id: foods.ids).includes(:food))
    end

    price = calculate_missing_price(missing_food)

    { data: missing_food, price: }
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

  # Internal: Calculates the total price for the array of missing food.
  #
  # Iterates through the missing_food array and acumulates the total price
  # of each individual record.
  #
  # Parameters: An array of recipe_foods.
  #
  # Returns an integer with the total price.

  def calculate_missing_price(missing_food)
    total_price = 0

    missing_food.each do |recipe_food|
      total_price += recipe_food.total_price
    end

    total_price
  end
end
