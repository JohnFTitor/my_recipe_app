class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { integer_only: true }
  # Internal: Total individual price
  #
  # No parameters
  #
  # Returns the individual total price of the ingredient

  def total_price
    food.price * quantity
  end
end
