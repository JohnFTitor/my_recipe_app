class FoodsController < ApplicationController

  #/foods
  def index
    @items = most_recent_added
  end

  def create

  end

  # public: gets the most recent posts from the database
  #
  # returns an array of at most 15 posts
  def most_recent_added
    Food.order(id: :desc).limit(15)
  end

  private

  def  foods_params
    params[]
  end
end
