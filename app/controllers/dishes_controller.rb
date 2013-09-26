class DishesController < ApplicationController

  def index
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first
    @dishes = @restaurant.dishes
  end

  def new
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first
  end

  def show
    for_url = params[:dishname].gsub(" ", "").downcase
    @dish = Dish.where(:url => for_url).first

    if @dish.nil?
      render 'not_found'
    end

  end

  def edit
    for_url = params[:dishname].gsub(" ", "").downcase
    @dish = Dish.where(:url => for_url).first

    if @dish.nil?
      render 'not_found'
    end
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

  def update
    @dish = Dish.find(params[:id])
    @dish.assign_attributes(dish_attributes)

    if @dish.save
      redirect_to @dish
    else
      render :edit
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    @restaurant = Restaurant.find(@dish.restaurant_id)
    
    if @dish
      @dish.destroy
      flash[:success] = "Dish Deleted"
    else
      flash[:error] = "Dish Was Not Found"
    end
    redirect_to @restaurant
  end
  
  private

  def dish_attributes
    params.require(:dish).permit(:name, :category, :description, :price, :url)
  end
end