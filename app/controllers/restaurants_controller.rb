class RestaurantsController < ApplicationController
	include RestaurantsHelper

	def index
		if request.xhr?
			@restaurants = Restaurant.search(params[:search]).includes(:dishes)
			p "@restaurants is now #{@restaurants.count}" + "*"*20
			render :partial => "search_results", :layout => false
		else
			@restaurants = Restaurant.limit(50)
			p "@restaurants is now #{@restaurants.count}" + "*"*20
		end
	end

	def new
		if logged_in?
			@restaurant = Restaurant.new
		else
			flash[:error] = "You must log in to add a new restaurant"
			redirect_to login_path
		end
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
			rest = Restaurant.where(:url => params[:url]).first
			rest ||= Restaurant.find(params[:id])
			puts rest.inspect
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
end