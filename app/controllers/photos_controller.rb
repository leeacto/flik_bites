class PhotosController < ApplicationController

def create
  @dish = Dish.find(params[:photo][:dish_id])
  @restaurant = @dish.restaurant

	if logged_in?
		@photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
		if @photo.save 
      flash[:success] = "Photo added!"
    else
      flash[:error] = "Please choose an image first"
    end
	else
    flash[:error] = "Please log in to add photos!"
  end
  redirect_to "/#{@restaurant.url}/#{@dish.url}"
end 

private 

def photo_params
	params.require(:photo).permit(:user_id, :dish_id, :image_file_name, :image)
end 

end
