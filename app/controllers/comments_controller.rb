class CommentsController < ApplicationController


	def create
		# puts "************************************************************"
		# puts params[:comments][:content]
		# puts params[:comments][:rating]
		# puts params[:comments][:dish_id]
		# puts params
		comment = Comment.create(user_id: current_user.id, dish_id: params[:comments][:dish_id], content: params[:comments][:content], rating: params[:comments][:rating])
		redirect_to "/"

		# redirect_to "/#{@restaurant.url}/#{@dish.url}"
	end 

end