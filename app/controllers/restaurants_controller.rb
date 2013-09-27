class RestaurantsController < ApplicationController

	def index
		if request.xhr?
			@restaurants = Restaurant.search(params[:search]).includes(:dishes).order("name")
			render :partial => "live_search", :layout => false
		else
			@restaurants = Restaurant.all.includes(:dishes)
		end
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		new_rest = Restaurant.new(restaurant_attributes)

		#Render URL
		if params[:restaurant][:name]
			potential = params[:restaurant][:name].downcase.gsub(' ','')
			new_rest.url = make_url(new_rest, potential)
		end
		
		#Get Lat/Lon? Or do AJAX Call on submission?

		if new_rest.save
			flash[:success] = "Restaurant Added"
			redirect_to "/#{new_rest.url}"
		else
			flash[:error] = "Restaurant was not saved"
			render 'new'
		end
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
		if params[:restaurant][:name] && params[:restaurant][:name] != @restaurant.name
			potential = params[:restaurant][:name].downcase.gsub(' ','')
			@restaurant.url = make_url(@restaurant, potential)
		end
		@restaurant.update_attributes(restaurant_attributes)
		@restaurant.save
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

	private
	
	def restaurant_attributes
  	params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :latitude, :longitude, :url)
  end
end