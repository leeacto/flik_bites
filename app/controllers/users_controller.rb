class UsersController < ApplicationController
  def create
    @user = User.new(first_name: params[:user][:first_name],
                     last_name: params[:user][:last_name],
                     zipcode: params[:user][:zipcode],
                     username: params[:user][:username], 
                     email: params[:user][:email],
                     password: params[:user][:password])
                   
    if @user.save
      session[:user_id] = @user.id
      redirect_to restaurants_path
    else
      flash[:error] = "There was an error with your request"
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find_by_username(params[:id])
  end

  def edit
    if current_user
     @user = User.find(current_user.id)
     render 'edit'
    else
      flash[:error] = "Please log in to edit your account"
      redirect_to login_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_attributes)
      redirect_to "/users/#{@user.username}"
    else
      @error = 'Profile Not Saved'
      render 'edit'
    end
  end

  def favdish
    @dish = Dish.find(params[:dish_id])
    @favorite = UserFavorite.find_by_user_id_and_dish_id(current_user.id,@dish.id)
    if @favorite
      UserFavorite.delete(@favorite)
      redirect_to :back
    else
      UserFavorite.create(user_id: current_user.id,restaurant_id: @dish.restaurant.id,dish_id: @dish.id )
      redirect_to :back
    end
  end

  def favrest
    @rest = Restaurant.find(params[:rest_id])
    @favorite = UserFavorite.find_by_user_id_and_restaurant_id(current_user.id,@rest.id)
    if @favorite
      UserFavorite.delete(@favorite)
      redirect_to :back
    else
      UserFavorite.create(user_id: current_user.id,restaurant_id: @rest.id,dish_id: 0 )
      redirect_to :back
    end
  end

  private

  def user_attributes
    params.require(:user).permit(:first_name,:last_name,:zipcode,:username, :email, :password_confirmation, :password)
  end
end
