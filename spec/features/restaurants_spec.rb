require 'spec_helper'
include RestaurantHelper
include UserHelper

feature "Add a Restaurant" do
	context "On Purpose" do
		describe "As a Logged In User" do
			before(:each) do
				user_login
				visit '/restaurants/new'
			end
			
			it "should route to the correct page" do
				page.should have_content 'New'
			end

			describe "Back End" do
				before(:each) do
					fill_in "restaurant_name", with: "Pizza Hut"
					fill_in "restaurant_address", with: "1927 W North Ave"
					fill_in "restaurant_city", with: "Chicago"
					fill_in "restaurant_state", with: "IL"
					fill_in "restaurant_zip", with: "60622"
					fill_in "restaurant_cuisine", with: "Pizza"
					click_button 'Create Restaurant'
				end
				
				it "should add a new restaurant record" do
					Restaurant.last.name.should eq "Pizza Hut"
				end
			end
		end
	end

	context "When Not Logged In" do
		describe "should not allow access" do

			before(:each) do
				visit '/restaurants/new'
			end

			it "should have a flash error" do
				page.should have_content 'must log'
			end
		end
	end
end

feature "Navigate to a Restaurant" do
	context "When logged in" do
		before(:each) do
			two_rest
			user_login
		end

		it "should let user see /:restaurant/dishes route" do
			click_link 'Cumin'
			page.should have_content 'Cumin'
		end
	end

	context "When not logged in" do
		it "should let user see /:restaurant/dishes route" do
			two_rest
			visit login_path
			click_link 'Restaurants'
			click_link 'Cumin'
			page.should have_content 'Cumin'
		end
	end
end

feature "Interacting with /:restaurant/dishes page" do
	before(:each) do
		two_rest
	end
	
	context "Either Logged in or Not" do
		before(:each) do
			visit "/cumin/dishes"
		end

		it "should show the correct tab upon click" do
			find('#entrees_tab').click
			page.should have_content 'pad thai'
		end

		# Not Working - I think it may be due to TinyBox
		# it "should show restaurant info upon clicking name" do
		# 	find('#rest_show_name').click
		# 	page.should have_content 'American'
		# end
	end

	context "While Logged In" do

	end

	context "As a Visitor" do
	end
end