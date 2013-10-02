class AccountsController < ApplicationController
  def update
    user = User.find(params[:format])
      if user.is_active?
        user.deactivate_account!
        session.clear
        flash[:error] = "we are sorry to see you go,come back anytime"
        redirect_to root_path
      else
        user.activate_account!
        redirect_to login_path
      end  
  end
end