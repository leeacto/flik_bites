require 'spec_helper'
include RestaurantHelper
include UserHelper

feature "Add a Restaurant" do
	context "On Purpose" do
		before(:each) do
			user_login
			visit '/restaurants/new'
		end
		
		it "should route to the correct page" do
			page.should have_content 'New'
		end

		it "should add a new restaurant and get to the page" do
			expect {
				fill_in "restaurant_name", with: "Pizza Hut"
				fill_in "restaurant_address", with: "123 F"
				fill_in "restaurant_city", with: "Chicago"
				fill_in "restaurant_state", with: "IL"
				fill_in "restaurant_zip", with: "60622"
				fill_in "restaurant_cuisine", with: "Pizza"
				click_button 'Create Restaurant'
			}.to change(Restaurant, :count).by(1)
		end
		it "should not accept a form with missing fields" do
			expect {
				fill_in "restaurant_address", with: "123 F"
				fill_in "restaurant_city", with: "Chicago"
				fill_in "restaurant_state", with: "IL"
				fill_in "restaurant_zip", with: "60622"
				fill_in "restaurant_cuisine", with: "Pizza"
				click_button 'Create Restaurant'
			}.to raise_error()
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

feature "Viewing a Dish" do

end