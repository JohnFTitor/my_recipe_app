class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :delete_all

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
end
