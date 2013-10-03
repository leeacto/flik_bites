require 'will_paginate/array'

class DishesController < ApplicationController
  before_action(:except => [:index, :show]) { |controller| controller.require_login(restaurants_path) }
  before_action :set_restaurant, :only => [:index, :new]
  
  def index
    if @restaurant
      if request.xhr?
        @restaurant = Restaurant.find_by_url(params[:url])
        if params[:search] == "All Dishes"
          @dishes =  Dish.where(restaurant_id: @restaurant.id).includes(:photos).paginate(:page => params[:page], :per_page => 24)
        else
          @dishes = Dish.where(restaurant_id: @restaurant.id).includes(:photos)
          @dish_cat = []
          @dishes.each do |d|
            @dish_cat << d if d.category.titleize == params[:search]
          end
          @dishes = @dish_cat.paginate(:page => params[:page], :per_page => 24)
        end
        render 'index_xhr', :layout => false
      else
        @dishes = Dish.where(restaurant_id: @restaurant.id).search(params[:search]).includes(:photos).paginate(:page => params[:page], :per_page => 24)
        @categories = Dish.where(restaurant_id: @restaurant.id).pluck(:category).uniq.map!{|c| c.titleize}
      end
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
      @norating = "No current rating"
      @photo = Photo.new
      @photos = Photo.where(:dish_id => @dish.id)
      @comment = Comment.where(:dish_id => @dish.id)
      if @comment.length > 0
        @comment_content = @comment.last.content
        @commenter = @comment.last
        @usercommenter = User.where(:id => @commenter.user_id)
      else
        @norating
      end
      @averagerating = [ ] 
      @comment.each do |x|
        @averagerating << x.rating
        @avr = (@averagerating.inject(:+))/ @averagerating.length
      end
    end
  end

  def edit
    for_url = params[:dishname].gsub(" ", "").downcase
    @dish = Dish.find_by(:url => for_url)

    if @dish.nil?
      render 'not_found'
    end
  end

  def create
    @restaurant = Restaurant.find_by(:url => params["dish"]["restname"])
    @curr_dishes = @restaurant.dishes

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

  def upload
    @photo = Photo.new
    @dish = Dish.find(params[:dish_id])
    render 'upload', :layout => false
  end
  
  private

  def dish_attributes
    params.require(:dish).permit(:name, :category, :description, :price, :url)
  end

  def set_restaurant
    @restaurant = Restaurant.find_by(:url => params[:restname].downcase)
    @restaurant ||= Restaurant.find_by(:url => params[:url])
  end
end