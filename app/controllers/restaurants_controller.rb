class RestaurantsController < ApplicationController
	def index
		@restaurants = Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def show
		@restaurant = Restaurant.where(:url => params[:restname].downcase).first
		if @restaurant.nil?
			render 'not_found'
		end
	end

	def edit
		@restaurant = Restaurant.where(:url => params[:restname].downcase).first
		
		if @restaurant.nil?
			render 'not_found'
		end
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		@restaurant.update_attributes(restaurant_attributes)
		redirect_to @restaurant
	end


	private
	
	def restaurant_attributes
  	params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :latitude, :longitude, :url)
  end
end