class RestaurantsController<ApplicationController
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
end