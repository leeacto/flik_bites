# omg so many hard tabs in this file. please replace them with soft tabs

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
    # Move this conditional to a before_filter
		if logged_in?
			@restaurant = Restaurant.new
		else
			flash[:error] = "You must log in to add a new restaurant"
			redirect_to login_path
		end
	end

  # Why don't you check for logged_in status here?
	def create
		new_rest = Restaurant.new(restaurant_attributes)

		#Render URL
		if params[:restaurant][:name] != ""
      # Can you move this downcase.gsub work into the make_url method?
			potential = params[:restaurant][:name].downcase.gsub(' ','')
			new_rest.url = make_url(new_rest, potential)
			if new_rest.save
				flash[:success] = "Restaurant Added"
				redirect_to "/#{new_rest.url}"
			else
				flash[:error] = "Restaurant was not saved"
				render 'new'
			end
		else
			flash[:error] = "The Restaurant Needs a Name"
			render 'new'
		end
		
		#Get Lat/Lon? Or do AJAX Call on submission?

	end

	def show
    # .find_by is a better choice when you are always calling .first on a query
		@restaurant = Restaurant.where(:url => params[:restname].downcase).first
		if @restaurant.nil?
			render 'not_found'
		end
	end

	def edit
    # no logged_in? check here?
		@restaurant = Restaurant.where(:url => params[:restname].downcase).first
		
		if @restaurant.nil?
			render 'not_found'
		end
	end

	def update
    # no logged_in? check here?
		@restaurant = Restaurant.find(params[:id])
		if params[:restaurant][:name] && params[:restaurant][:name] != @restaurant.name
      # if you're frequently generating slugs based on a restaurant's name, take a look at https://github.com/rsl/stringex
			potential = params[:restaurant][:name].downcase.gsub(' ','')
			@restaurant.url = make_url(@restaurant, potential)
		end
    # do you need to call .save after calling .update_attributes? go read the docs to find out
		@restaurant.update_attributes(restaurant_attributes)
		@restaurant.save
		redirect_to @restaurant
	end

	def destroy
    # so anyone can delete any restaurant? let me know when this is live so I can ask
    # my script-kiddie cousin to  delete all your data ;)
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
		render 'desc'
	end

	private
	
	def restaurant_attributes
  	params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :latitude, :longitude, :url)
  end
end
