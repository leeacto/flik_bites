class PhotosController < ApplicationController

def create
	puts params
	@photo = Photo.new(photo_params)
	@photo.save

	redirect_to '/'
end 

private 

def photo_params
	params.require(:photo).permit!
end 

end
