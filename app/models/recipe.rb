class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :delete_all

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
end
