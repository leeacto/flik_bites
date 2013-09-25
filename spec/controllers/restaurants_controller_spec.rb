require 'spec_helper'
include RestaurantHelper

describe "RestaurantController" do
	describe '#index' do
		it "should show a list of restaurants" do
			two_rest
			visit '/restaurants'
			page.should have_content 'Bristol'
			page.should have_content 'Cumin'
		end
	end

	describe "#show" do
		it "should render the correct restaurant" do
			two_rest
			visit '/Cumin'
			page.should have_content 'Cumin'
		end
	end

	
end