require 'spec_helper'


include RestaurantHelper

describe RestaurantsController do
	before(:each) do
	end
	
	describe 'GET #index' do
		it "should route to index path" do
			get :index
			response.should render_template :index
		end

		it "should populate an array of restaurants" do
			@rs = two_rest
			get :index
			assigns(:restaurants).should eq(@rs)
		end
	end

	describe '#new' do
		it 'should route to the new restaurant page' do
			get :new
			response.should render_template :new
		end
	end

	describe "#show" do
		it "should render the correct restaurant" do
			two_rest
			get :show, :restname => 'theBristol'
			response.should render_template :show
		end

		it "should render an error page on incorrect restaurant" do
			get :show, :restname => 'fakerest'
			response.should render_template :not_found
		end
	end

	describe '#edit' do
		it "should get to the edit page" do
			two_rest
			get :edit, :restname => 'cumin'
			response.should render_template :edit
		end
	end
	
>>>>>>> master
end