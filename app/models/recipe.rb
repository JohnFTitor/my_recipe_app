class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  # Internal: Calculates total cost of foods.
  #
  # Iterates through the entire foods list and calculates
  # the total price by incrementing an acumulator variable.
  #
  # No Parameters.
  #
  # Returns an integer with the total price.

  def total_cost
    total_price = 0
    ingredients = recipe_foods.includes(:food)
    ingredients.each do |ingredient|
      total_price += ingredient.total_price
    end
    total_price
  end

  # Internal: Retrieves all the public recipes.
  #
  # Makes a query that fetches all the public recipes ordered by creating date
  # and includes the food collection. This operation avoids N+1 queries.
  #
  # No parameters.
  #
  # Returns an array of recipes.

  def self.public_recipes
    all.where(public: true).order(created_at: :desc).includes(:foods)
  end

  # Internal: Calculates total ingredient items.
  #
  # No parameters.
  #
  # Returns an integer with the length of food collection

  def total_ingredients
    foods.length
  end
end
