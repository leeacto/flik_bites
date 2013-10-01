class PhotosController < ApplicationController
  before_action :require_login

  def create
    @photo = Photo.new(photo_params)

    @dish = Dish.find(params[:photo][:dish_id])
    
    if @dish 
      @restaurant = @dish.restaurant
      if @photo.save 
        @photo.update(user_id: current_user.id)
        flash[:success] = "Photo added!"
      else
        flash[:error] = "Please choose an image first"
      end
      redirect_to "/#{@restaurant.url}/#{@dish.url}"
    else
      flash[:error] = "Dish was not found"
      redirect_to :back
    end
  end 

  private 

  def photo_params
  	params.require(:photo).permit(:user_id, :dish_id, :image_file_name, :image)
  end 

end
