class PhotosController < ApplicationController

def create
	puts params
	@photo = Photo.new(photo_params)
	@photo.save

	redirect_to '/'
end 

private 

def photo_params
	params.require(:photo).permit(:user_id, :dish_id, :image_file_name, :image)
end 

end
