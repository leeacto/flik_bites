class UsersController < ApplicationController
  def create
	  @user = User.new(first_name: params[:user][:first_name],
									   last_name: params[:user][:last_name],
									   zipcode: params[:user][:zipcode],
									   username: params[:user][:username], 
									   email: params[:user][:email],
									   password: params[:user][:password],
									   password_confirmation:params[:user][:password_confirmation])

    if @user.save
	    session[:user_id] = @user.id
	    redirect_to root_path
	  else
	  	flash[:error] = "There was an error with your request"
	    redirect_to new_user_path
	  end
  end

  def show
  	@user = User.find_by_username(params[:user])
  end
end