class PhotosController < ApplicationController

def create
  p params
  @dish = Dish.find(params[:photo][:dish_id])
  p @dish
  @restaurant = @dish.restaurant

	if logged_in?
		@photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
		@photo.save
    flash[:success] = "Photo added!"
    redirect_to "/#{@restaurant.url}/#{@dish.url}"
	else
    flash[:error] = "Please log in to add photos!"
		redirect_to "/#{@restaurant.url}/#{@dish.url}"
  end
end 

private 

def photo_params
	params.require(:photo).permit(:user_id, :dish_id, :image_file_name, :image)
end 

end
