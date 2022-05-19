class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def total_cost
    total_price = 0
    foods.each do |food|
      total_price += food.price
    end
    total_price
  end

  def self.public_recipes
    all.where(public: true).order(created_at: :desc).includes(:foods)
  end

  def total_ingredients
    foods.length
  end
end
