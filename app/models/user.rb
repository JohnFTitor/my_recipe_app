class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :recipes, dependent: :delete_all
  has_many :foods, dependent: :delete_all

  validates :name, presence: true
  
  def get_recipes
    recipes.order(created_at: :desc)
  end
end
