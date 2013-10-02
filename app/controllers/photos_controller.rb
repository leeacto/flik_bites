class PhotosController < ApplicationController
  before_action :require_login
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def create
    @photo = Photo.new(photo_params)
    @dish = Dish.find(params[:photo][:dish_id])
    @restaurant = @dish.restaurant
    
    if @photo.save 
      @photo.update(user_id: current_user.id)
      flash[:success] = "Photo added!"
    else
      flash[:error] = "Please choose an image first"
    end

    redirect_to "/#{@restaurant.url}/#{@dish.url}"
  end 

  private 

  def photo_params
    params.require(:photo).permit(:user_id, :dish_id, :image_file_name, :image)
  end 

  def record_not_found
    flash[:error] = "Dish was not found"
    redirect_to restaurants_path
  end

end
