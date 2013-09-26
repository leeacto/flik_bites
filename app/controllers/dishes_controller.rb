class DishesController < ApplicationController

  def index
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first
    @dishes = @restaurant.dishes
  end

  def show
    @dish = Dish.where(:url => params[:dishname].downcase).first
  end

end