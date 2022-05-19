class FoodsController < ApplicationController
  before_action :authenticate_user!

  # /foods
  def index
    @items = most_recent_added
  end

  # /foods (post)
  def create
    food = Food.new(foods_params)
    food.user = current_user

    if food.save
      flash[:success] = 'Food has been created'
    else
      flash[:alert] = 'Error'
    end
    redirect_to foods_path
  end

  # /foods/:id (delete)
  def destroy
    if Food.find(params[:id]).destroy
      flash[:success] = 'Food has been deleted'
    else
      flash[:alert] = 'Error'
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
    params[:foods].permit(:name, :measurement_unit, :price)
  end
end
