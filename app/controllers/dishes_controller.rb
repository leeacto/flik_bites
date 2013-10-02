class DishesController < ApplicationController
  before_action(:except => [:index, :show]) { |controller| controller.require_login(restaurants_path) }
  before_action :set_restaurant, :only => [:index, :new]
  
  def index
    if @restaurant
      @dishes = @restaurant.dishes.includes(:photos)
    else
      flash[:error] = "Restaurant not found"
      redirect_to_back
    end
  end

  def new
    if @restaurant
      @curr_dishes = @restaurant.dishes
      @dish = Dish.new
      render 'new'
    else
      flash[:error] = "Restaurant not found"
      redirect_to @restaurant
    end
  end

  def show
    for_url = params[:dishname].gsub(" ", "").downcase
    @dish = Dish.find_by(:url => for_url)
    if @dish.nil?
      render 'not_found'
    else
      @photo = Photo.new
      @photos = Photo.where(:dish_id => @dish.id)
    end
  end

  def edit
    for_url = params[:dishname].gsub(" ", "").downcase
    @dish = Dish.find_by(:url => for_url)

    if @dish.nil?
      render 'not_found'
    end
  end

  # REVIEW(RCB): this will throw an execption if restaurant isn't found.
  def create
    @restaurant = Restaurant.find_by(:url => params["dish"]["restname"])
    @curr_dishes = @restaurant.dishes

    @dish = @restaurant.dishes.new(dish_attributes)
    unless @dish.name.nil?
      potential = @dish.name.downcase.gsub(' ','')
      # REVIEW(RCB): like my comments about restaurants, making urls for dishes should be done in the model via callback
      @dish.url = make_url(@dish, potential)
      if @dish.save
        flash[:success] = "New Dish Added!"
        redirect_to "/#{@restaurant.url}/#{@dish.url}"
      else
        flash[:error] = "The Dish Was Not Saved"
        render :new
      end
    else
      flash[:error] = "The Dish Must Have a Name"
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

  def set_restaurant
    @restaurant = Restaurant.find_by(:url => params[:restname].downcase)
  end
end
