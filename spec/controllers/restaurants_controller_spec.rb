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

	describe 'GET #new' do
		it 'should route to the new restaurant page' do
			get :new
			response.should render_template :new
		end
	end

	describe "GET #show" do
		it "should render the restaurant page given valid restaurant" do
			two_rest
			get :show, :restname => 'theBristol'
			response.should render_template :show
		end

		it "should have the correct restaurant attribute" do
			rs = two_rest
			get :show, :restname => 'theBristol'
			assigns(:restaurant).should eq rs.first
		end

		it "should render an error page on incorrect restaurant" do
			get :show, :restname => 'fakerest'
			response.should render_template :not_found
		end
	end

	describe 'GET #edit' do
		it "should get to the edit page" do
			two_rest
			get :edit, :restname => 'cumin'
			response.should render_template :edit
		end

		it "should prepare to edit the correct restaurant" do
			rs = two_rest
			get :edit, :restname => 'theBristol'
			assigns(:restaurant).should eq rs.first
		end
	end

	describe 'PUT #update' do 

		before(:each) do
			@b = one_rest
			@attr = {:name => 'bristol'}
		end

		it "should look to update the correct restaurant" do
			put :update, :id => @b.id, :restaurant => @attr
			assigns(:restaurant).should eq @b
		end

		it "should update the restaurant's attribute" do
			put :update, :id => @b.id, :restaurant => @attr
			@b.reload
			@b.name.should eq ('bristol')
		end
	end
end