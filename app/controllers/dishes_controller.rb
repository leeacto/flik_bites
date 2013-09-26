class DishesController < ApplicationController

  def index
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first
    @dishes = @restaurant.dishes
  end

end