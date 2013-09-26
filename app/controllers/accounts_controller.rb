class AccountsController < ApplicationController
	def update
		user = User.find(params[:format])
		if current_user !=nil && current_user.id == user.id
			if user.is_active?
				user.deactivate_account!
				session.clear
				flash[:error] = "we are sorry to see you go please come back anytime"
				redirect_to root_path
			else
				user.activate_account!
				redirect_to login_path
			end	
		else
			flash[:error] = "You do not have access to perform that operation"
			redirect_to root_path
		end
	end
end