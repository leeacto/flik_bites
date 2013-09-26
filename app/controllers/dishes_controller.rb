class DishesController < ApplicationController

  def index
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first
    @dishes = @restaurant.dishes
  end

  def show
    for_url = params[:dishname].gsub(" ", "").downcase
    @dish = Dish.where(:url => for_url).first
  end

  def new
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first
  end

  def create
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first
    @dish = @restaurant.dishes.new(dish_attributes)

    if @dish.save
      redirect_to @restaurant 
    else
      render :new
    end
  end

  def edit
  end

  private

  def dish_attributes
    params.require(:dish).permit(:name, :category, :description, :price, :url)
  end
end