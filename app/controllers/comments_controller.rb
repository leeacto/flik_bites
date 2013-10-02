class CommentsController < ApplicationController
	def create
		if logged_in?
			@comment = Comment.new(user_id: current_user.id, dish_id: params[:comments][:dish_id], content: params[:comments][:content], rating: params[:comments][:rating])
			if @comment.save
				redirect_to_back
			else 
				flash[:error] = "Sorry, one comment per user"
				redirect_to_back
			end
		else 
			flash[:error] = "You must log in to comment"
      		redirect_to_back 
    	end
	end 
end