require 'spec_helper'


include RestaurantHelper

describe RestaurantsController do
	
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

		context "with an ajax request" do
			it "has a 200 status code" do
				xhr :get, :index
				response.code.should eq "200"
			end

			it "renders the live_search partial" do
				xhr :get, :index
				response.should render_template :_live_search
			end
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
			@b, @c = two_rest
			@attr = {:name => 'Bristol'}
		end

		it "should look to update the correct restaurant" do
			put :update, :id => @b.id, :restaurant => @attr
			assigns(:restaurant).should eq @b
		end

		it "should update the restaurant's attribute" do
			put :update, :id => @b.id, :restaurant => @attr
			@b.reload
			@b.name.should eq ('Bristol')
		end

		describe "url naming" do
			it "should be given the correct url when name changes" do
				put :update, :id => @b.id, :restaurant => @attr
				@b.reload
				@b.url.should eq 'bristol'
			end

			it "should be given the correct url when other attrib changes" do
				put :update, :id => @b.id, :restaurant => { :address => "fake address" }
				@b.reload
				@b.url.should eq 'thebristol'
			end

			it "should be given the correct url when another restaurant exists" do
				put :update, :id => @c.id, :restaurant => {:name => 'The Bristol'}
				Restaurant.last.url.should eq 'thebristol2'
			end
		end
	end

	describe 'POST #create' do
		before(:each) do
			@attr = { :name => "Cumin", 
	                :address => "1414 N Milwaukee Ave",
	                :city => "Chicago",
	                :state => "IL",
	                :zip => 60622,
	                :cuisine => "Indian / Nepalese",
	                :latitude => 42.298697,
	                :longitude => -87.956501
               }
      @attr_t = { :name => "Cumin", 
	                :address => "1416 N Milwaukee Ave",
	                :city => "Chicago",
	                :state => "IL",
	                :zip => 60622,
	                :cuisine => "Indian / Nepalese",
	                :latitude => 42.298697,
	                :longitude => -87.956501
               }
		end

		context "with valid attributes" do

			it "should create a new restaurant given valid attributes" do
	      expect {
	      	post :create, restaurant: @attr
	      }.to change(Restaurant, :count).by(1)
			end

			it "should route to the new restaurant" do
				post :create, restaurant: @attr
				response.should redirect_to "/#{Restaurant.last.url}"
			end

			describe "url naming" do
				it "should be given the correct url" do
					post :create, restaurant: @attr_t
					Restaurant.last.url.should eq 'cumin'
				end

				it "should be given the correct url when another restaurant exists" do
					c = Restaurant.create(@attr)
					c.url = 'cumin'
					c.save
					post :create, restaurant: @attr_t
					Restaurant.last.url.should eq 'cumin2'
				end
			end
		end

		context 'with invalid attributes' do
			it "should deny a new restaurant" do
	      @attr.delete(:address)
	      expect {
	      	post :create, restaurant: @attr
	      }.not_to change(Restaurant, :count)
			end

			it "should render the new template" do
				@attr.delete(:address)
      	post :create, restaurant: @attr
      	response.should render_template 'new'
			end
		end
	end

	describe 'DELETE #destroy' do
		before(:each) do
			@r = one_rest
		end

		context "with previously created restaurant" do

			it "should find the correct restaurant" do
				delete :destroy, id: @r.id
				assigns(:restaurant).should eq @r
			end

			it "should reduce restaurant count" do
				expect {
					delete :destroy, id: @r.id
					}.to change(Restaurant, :count).by(-1)
			end
		end

		context "with invalid restaurant" do
			it "should flash an error" do
				delete :destroy, id: 7
				flash.now[:error].should =~ /Not Found/i
			end
		end

		it "should redirect restaurants page" do
			delete :destroy, id: @r.id
			response.should redirect_to '/restaurants'
		end
	end
end