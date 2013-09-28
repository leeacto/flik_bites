class DishesController < ApplicationController

  def index
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first
    @dishes = @restaurant.dishes
  end

  def new
    @restaurant = Restaurant.where(:url => params[:restname].downcase).first

    if current_user
      @dish = Dish.new
      render 'new'
    else
      flash[:error] = "You must be signed in to add a dish"
      redirect_to "/#{@restaurant.url}"
    end
  end

  def show
    for_url = params[:dishname].gsub(" ", "").downcase
    @dish = Dish.where(:url => for_url).first
    if @dish.nil?
      render 'not_found'
    else
      @photo = Photo.new
      @photos = Photo.where(:dish_id => @dish.id)
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
    @restaurant = Restaurant.where(:url => params["restname"]).first
    if current_user
      @dish = @restaurant.dishes.new(dish_attributes)
      unless @dish.name.nil?
        potential = @dish.name.downcase.gsub(' ','')
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
    else
      flash[:error] = "You must be signed in to add a dish"
      redirect_to "/#{@restaurant.url}"
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
  
  def photo_new
    puts "*******************************************"
    @what = params
  end 
  
  private

  def dish_attributes
    params.require(:dish).permit(:name, :category, :description, :price, :url)
  end
end