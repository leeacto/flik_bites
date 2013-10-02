require 'spec_helper'
include RestaurantHelper
include UserHelper

feature 'Create comment for dish' do
	context "As a Logged In User" do
		before(:each) do
			two_rest
			user_login
		end

		it "should access dish view page" do
			click_link 'Cumin'
		end
	end
end

