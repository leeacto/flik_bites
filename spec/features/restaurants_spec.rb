require 'spec_helper'
include RestaurantHelper

describe "Restaurant" do
	describe '#index' do
		it "should show a list of restaurants" do
			two_rest
			visit '/restaurants'
			page.should have_content 'Bristol'
			page.should have_content 'Cumin'
		end
	end

	describe '#new' do
		it 'should route to the new restaurant page' do
			visit '/restaurants/new'
			
		end
	end

	describe "#show" do
		it "should render the correct restaurant" do
			two_rest
			visit '/theBristol'
			page.should have_content 'Bristol'
		end

		it "should render an error page on incorrect restaurant" do
			visit '/fakerest'
			page.should have_content 'Add New Restaurant'
		end
	end

	describe '#edit' do
		it "should get to the edit page" do
			two_rest
			visit '/cumin/edit'
			page.should have_content 'Edit Cumin'
		end
	end

	# describe "#update" do
	# 	it "should update restaurant profile" do
	# 		two_rest
	# 		visit '/cumin/edit'
	# 		fill_in 'restaurant_name', with: 'Cumin2'
	# 		click_button 'Update Restaurant'
	# 		page.should have_content 'Cumin2'
	# 	end
	# end
	
end