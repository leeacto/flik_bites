class RestaurantsController<ApplicationController
	def index
		@restaurants = Restaurant.all
	end

	def show
		@restaurant = Restaurant.where(:name => params[:restname]).first
	end
end