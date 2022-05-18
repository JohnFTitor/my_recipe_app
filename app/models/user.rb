class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :recipes, dependent: :delete_all
  has_many :foods, dependent: :delete_all

  validates :name, presence: true
  
  #Internal: Retrieves recipes entries for the user in descending order.
  #
  # No Parameters.
  #
  # Returns the array of recipes.

  def get_recipes
    recipes.order(created_at: :desc)
  end
end
