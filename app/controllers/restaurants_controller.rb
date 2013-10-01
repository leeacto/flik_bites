class RestaurantsController < ApplicationController
  include RestaurantsHelper
  before_action :require_login, only: [:new, :create, :edit, :destroy]

  def index
    if request.xhr?
      @restaurants = Restaurant.search(params[:search]).includes(:dishes)
      render :partial => "search_results", :layout => false
    else
      @restaurants = Restaurant.all.includes(:dishes)
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    new_rest = Restaurant.new(restaurant_attributes)
    if params[:restaurant][:name] != ""
      potential_url = params[:restaurant][:name].downcase.gsub(' ','')
      new_rest.url = make_url(new_rest, potential_url)
      if new_rest.save
        if request.xhr?
          loc = {}
          loc[:id] = new_rest.id
          loc[:address] = street_city(new_rest)
          render :json => loc
        else
          flash[:success] = "Restaurant Added"
          redirect_to "/#{new_rest.url}/dishes"
        end
      else
        flash[:error] = "Restaurant was not saved"
        render 'new'
      end
    else
      @restaurant = new_rest
      flash[:error] = "The Restaurant Needs a Name"
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find_by_url(params[:restname].downcase)
    if @restaurant.nil?
      render 'not_found'
    end
  end

  def edit
    @restaurant = Restaurant.find_by_url(params[:restname].downcase)
    
    if @restaurant.nil?
      render 'not_found'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if params[:restaurant][:name] && params[:restaurant][:name] != @restaurant.name
      potential = params[:restaurant][:name].downcase.gsub(' ','')
      @restaurant.url = make_url(@restaurant, potential)
    end
    @restaurant.update_attributes(restaurant_attributes)
    redirect_to @restaurant
  end

  def destroy
    @restaurant = Restaurant.find(params[:id]) if Restaurant.exists?(params[:id])
    if @restaurant
      @restaurant.destroy
      flash[:success] = "Restaurant Deleted"
    else
      flash[:error] = "Restaurant Was Not Found"
    end
    redirect_to '/restaurants'
  end

  def desc
    @rest = Restaurant.where(:url => params[:restname]).first
    render 'desc', :layout => false
  end

  def coords
    if request.xhr?
      coords = {}
      @rest = Restaurant.where(:url => params[:restname]).first
      coords[:latitude] = @rest.latitude
      coords[:longitude] = @rest.longitude
      coords[:address] = street_city(@rest)
      render :json => coords
    end
  end

  def setcoords
    if params[:url] || params[:id]
      rest = Restaurant.find_by_url(params[:url])
      rest ||= Restaurant.find(params[:id])
      rest.latitude = params[:lat]
      rest.longitude = params[:lon]
      rest.save
      render json: rest
    end
  end

  private
  
  def restaurant_attributes
    params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :latitude, :longitude, :url, :cuisine)
  end

  def require_login
    unless logged_in?
    flash[:error] = "You must log in to add a new restaurant"
    redirect_to login_path
    end
  end
end