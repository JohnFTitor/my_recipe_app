class FoodsController < ApplicationController
  before_action :authenticate_user!

  # /foods
  def index
    @items = current_user.foods.order(created_at: :desc)
  end

  # /foods (post)
  def create
    food = Food.new(foods_params)
    p food
    food.user = current_user

    if food.save
      flash[:success] = 'Food item has been created'
    else
      flash[:alert] = 'Food item could not be saved'
    end
    redirect_to foods_path
  end

  # /foods/:id (delete)
  def destroy
    if Food.find(params[:id]).destroy
      flash[:success] = 'Food item has been deleted'
    else
      flash[:alert] = 'Food item could not be deleted'
    end
    redirect_to foods_path
  end

  # public: gets the most recent posts from the database
  #
  # returns an array of at most 15 posts
  def most_recent_added
    Food.order(id: :desc).limit(15)
  end

  private

  def foods_params
    par = params[:foods].permit(:name, :measurement_unit, :price)
    par[:price] = par[:price].to_f
    par
  end
end
