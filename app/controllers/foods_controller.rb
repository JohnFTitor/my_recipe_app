class FoodsController < ApplicationController
  before_action :set_foods

  def index
    @items = @foods
  end

  private

  def most_recent_added
    Food.all.limit(15)
  end

  def set_foods
    @foods = most_recent_added
  end
end
