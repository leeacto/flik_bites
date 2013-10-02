class CommentsController < ApplicationController
	def create
		comment = Comment.create(user_id: current_user.id, dish_id: params[:comments][:dish_id], content: params[:comments][:content], rating: params[:comments][:rating])
		redirect_to "/"
	end 
end