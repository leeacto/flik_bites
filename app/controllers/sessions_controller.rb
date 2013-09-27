class SessionsController < ApplicationController

	def create
  	@user = User.find_by_username(params[:session][:username])
    if @user == nil
      flash[:error] = "The user you have entered does not exist"
      redirect_to login_path
    else
      if @user.is_active?
        if  @user.authenticate(params[:session][:password])
          session[:user_id] = @user.id
          redirect_to restaurants_path
        else
          flash[:error] = "Username or Password is incorrect"
          redirect_to login_path, :notice => "Signed in!"
        end
      else
        @error = "Your account is not active"
        render 'accounts/update'
      end
    end
  end

  def destroy
    session.clear
    redirect_to  root_path
  end
end