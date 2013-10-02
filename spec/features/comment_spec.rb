require 'spec_helper'
include RestaurantHelper
include UserHelper

feature 'Create comment for dish' do
	context "As a Logged In User" do
		before(:each) do
			two_rest
			user_login
		end

		it "visit dish view page comment" do
			visit '/thebristol/pizza'
			page.should have_content('Name: Pizza')
			click_button 'review_button'
			expect {
				fill_in 'comments_content', with: 'what is this'
				click_button 'Post Review'
			}.to change(Comment, :count).by(1)
		end
	end
end

feature 'Unable to create comment, user not logged in' do
	context "As a Logged In User" do
		before(:each) do
			two_rest
		end

		it "visit dish view page comment" do
			visit '/thebristol/pizza'
			page.should have_content('Name: Pizza')
			click_button 'review_button'
			expect {
				fill_in 'comments_content', with: 'what is this'
				click_button 'Post Review'
			}.to_not change{Comment.count}
		end
	end
end

feature 'Not create more than one comment per user' do
	context "As a Logged In User" do
		before(:each) do
			two_rest
			user_login
		end

		it "visit dish view page comment" do
			visit '/thebristol/pizza'
			page.should have_content('Name: Pizza')
			click_button 'review_button'
			expect {
				fill_in 'comments_content', with: 'what is this'
				click_button 'Post Review'
			}.to change(Comment, :count).by(1)
			visit '/thebristol/pizza'
			page.should have_content('Name: Pizza')
			click_button 'review_button'
			expect {
				fill_in 'comments_content', with: 'what is this'
				click_button 'Post Review'
			}.to_not change{Comment.count}
		end
	end
end