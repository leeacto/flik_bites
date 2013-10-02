# require 'spec_helper'
# include UserHelper


# describe CommentsController do

# 	describe Comment do
# 	    describe "Create comment" do
# 	    	it "should create a new comment" do
# 	      		expect { Comment.create(content: "good stuff", 
# 	        		rating: 1, 
# 	         		user_id: 1, 
# 	         		dish_id: 1) }.to change(Comment, :count).by(1)
# 	      	end 

# 	      	it "should not create comment, input not valid" do
# 	        	expect { Comment.create(content: " ", 
# 	        		rating: 1, 
# 	         		user_id: 1, 
# 	         		dish_id: 1) }.to_not change{Comment.count}
# 	      	end
# 	    end
# 	end 
# end