require 'spec_helper'
include UserHelper
include RestaurantHelper
feature UsersController do
  describe User do
    describe "Create User" do
      before(:each) do
        @attr = { 
          :username => "TestUserName",
          :first_name => "TestFirst", 
          :last_name => "TestLast", 
          :zipcode => "60060", 
          :email => "user@example.com",
          :password => "foobar"
        }
      end

       it "should create a new user in database with valid input" do
         expect { User.create!(@attr) }.to change(User, :count).by(1)
      end

      it "should not be able to create without valid input" do
        User.create(:username => "TestUserName",
          :first_name => "TestFirst", 
          :last_name => "s", 
          :zipcode => "60060", 
          :email => "usereample.com",
          :password => "fooar")
          session[:user_id].should eq nil
      end
    end

    describe "Show User" do
      before(:each) do
        @user = one_user
      end

      it "should assign the proper user to the instance variable" do
        get :show, id: @user.username
        assigns(:user).should eq(@user)
      end

      it "should render the propper view" do
        get :show, user: @user.username
        response.should render_template :show
      end
    end

    describe "Edit User" do
      before(:each) do
        @user = one_user
      end

      it "should assign the proper user to the instance variable" do
        session[:user_id] = @user.id 
        get :edit, :id => @user.id
        assigns(:user).should eq(@user)
      end

      it "should render the propper view" do
        session[:user_id] = @user.id 
        get :edit, :id => @user.id
        response.should render_template :edit
      end

      it 'should redirect you to login if not logged in' do
        get :edit, :id => 3
        response.should redirect_to login_path
      end
    end

    describe "Update User" do
      before(:each) do
        @user = one_user
      end
      context 'valid input' do
        before(:each) do
          post :update,  :id => @user.id, :user => {:first_name => 'test',
                                                    :last_name => 'test2',
                                                    :zipcode => '60042',
                                                    :username => 'user', 
                                                    :email => "test@test.com",
                                                    :password => 'password'}
          @user.reload
        end
        it 'should be able to change the first name' do
          @user.first_name.should eq 'test'
        end
        it 'should be able to change the last name' do
          @user.last_name.should eq 'test2'
        end
        it 'should be able to change the zipcode' do
          @user.zipcode.should eq '60042'
        end
        it 'should be able to change the username' do
          @user.username.should eq 'user'
        end
        it 'should be able to change the email' do
          @user.email.should eq 'test@test.com'
        end
        it 'should be able to redirect with propper information' do
          response.should redirect_to '/users/user'
        end
      end
      context 'invalid input' do
        it 'should not be able to edit with invalid input' do
          post :update, :id => @user.id, :user => {:email => 'test.com'}
          response.should render_template :edit
        end
      end
    end
  end
  describe "User Favorites Page" do
    before(:each) do
      @user = one_user
      session[:user_id] = @user.id
      request.env["HTTP_REFERER"] = 'http://test.host/restaurant'
    end

    it 'should show all the item user has starred if they have stared any' do
      @rest = one_rest
      @dish = @rest.dishes.first
      post :favdish, :dish_id => @dish.id
      get 'favorites'
      assigns(:dishes).should eq(@user.dishes)
      assigns(:restaurants).should eq(@user.restaurants)
      response.should render_template :favorites
    end

    it 'should show nothing if they havent stared anything' do
      get 'favorites'
      assigns(:dishes).should eq(@user.dishes)
      assigns(:restaurants).should eq(@user.restaurants)
      response.should render_template :favorites
    end
  end

  describe "Users Favorites Restaurant" do
    before(:each) do
      @user = one_user
      @rest = one_rest
      request.env["HTTP_REFERER"] = 'http://test.host/restaurant'
    end

    it 'should be able to star a restaurant' do
      session[:user_id] = @user.id
      expect {
              post :favrest, :rest_id => @rest.id
              }.to change(UserFavorite, :count).by(1)
      response.should redirect_to :back
    end

    it 'should be able to un-star a restaurant' do
      session[:user_id] = @user.id
      post :favrest, :rest_id => @rest.id
      response.should redirect_to :back
      
      expect {  
               post :favrest, :rest_id => @rest.id
              }.to change(UserFavorite, :count).by(-1)
      response.should redirect_to :back
    end

    it 'should not let you favorite if you are not logged in' do  
      post :favrest, :rest_id => @rest.id
      flash.now[:error].should eq 'Please log in first'
    end
  end

  describe 'User favorite Dishes' do
    before(:each) do
      @user = one_user
      @rest = one_rest
      @dish = @rest.dishes.first
      request.env["HTTP_REFERER"] = 'http://test.host/dish'
    end

    it 'should be able to star a dish if logged in' do
      session[:user_id] = @user.id
      expect {
              post :favdish, :dish_id => @dish.id
              }.to change(UserFavorite, :count).by(1)
      response.should redirect_to :back
    end

    it 'should be able to un-star a dish' do
      session[:user_id] = @user.id
      post :favdish, :dish_id => @dish.id
      response.should redirect_to :back
      
      expect {  
               post :favdish, :dish_id => @dish.id
              }.to change(UserFavorite, :count).by(-1)
      response.should redirect_to :back
    end

    it 'should not let you favorite if you are not logged in' do  
      post :favdish, :dish_id => @dish.id
      flash.now[:error].should eq 'Please log in first'
    end
  end


end