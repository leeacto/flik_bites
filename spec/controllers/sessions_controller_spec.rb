require 'spec_helper'

describe SessionsController do
	describe "#create" do
		before(:each) do
			@user = User.create!(:username => "TestUserName",
										  		 :first_name => "TestFirst", 
										  		 :last_name => "TestLast", 
										  		 :zipcode => "60060", 
										  		 :email => "user@example.com",
										  		 :password => "foobar")		 	
		end
		it "should be able to create a session" do
			post :create,{session: {username: 'TestUserName', password: 'foobar'}}
			session[:user_id].should eq @user.id
		end

		it "should redirect you to root and keep session nil if incorrect info" do
			post :create,{session: {username: 'TestUserName', password: 'fobar'}}
			session[:user_id].should eq nil
			response.should redirect_to(login_path)
		end
	end

	describe "#destroy" do
		before(:each) do 
			session[:user_id] = 1
		end

		it "should be able to clear session on logout" do
			get :destroy
			session[:user_id].should eq nil
		end
	end
	
	describe "Should be able to check status of active" do
		it 'should log in normal if user is active' do
			@user = User.create!(:username => "TestUserName",
										  		 :first_name => "TestFirst", 
										  		 :last_name => "TestLast", 
										  		 :zipcode => "60060", 
										  		 :email => "user@example.com",
										  		 :password => "foobar")
			post :create,{session: {username: 'TestUserName', password: 'foobar'}}
			session[:user_id].should eq @user.id	
		end

		it 'should redirect to activation page if user is inactive' do
			@user = User.create!(:username => "TestUserName",
										  		 :first_name => "TestFirst", 
										  		 :last_name => "TestLast", 
										  		 :zipcode => "60060", 
										  		 :email => "user@example.com",
										  		 :password => "foobar",
										  		 :is_active => false)
			post :create,{session: {username: 'TestUserName', password: 'foobar'}}
			session[:user_id].should eq nil
			response.should render_template("accounts/update")

		end
	end

	describe "omniauth testing" do
				
		it "should be able to log in with facebook if user does not exists" do
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
			get 'createoauth'
			session[:user_id].should eq User.last.id
			response.should redirect_to root_path
		end

		it "should be able to log in with google if user does not exists" do
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
			get 'createoauth'
			session[:user_id].should eq User.last.id
			response.should redirect_to root_path
		end

		it "should be able to log in with twitter if user does not exists" do
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  		get 'createoauth'
			session[:user_id].should eq User.last.id
			response.should redirect_to root_path
		end

		it 'should be able to find the user if they have signed in before with facebook' do
			@user = User.create(:username => "TestUserName",
										  		 :email => "foo@bar.com",
										  		 :password => "foobar",
										  		 :provider => 'facebook',
    											 :uid => '123545')
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  		get 'createoauth'
			session[:user_id].should eq @user.id
			response.should redirect_to root_path
		end

		it 'should be able to find the user if they have signed in before with google' do
			@user = User.create(:username => "TestUserName",
										  		 :email => "foo@bar.com",
										  		 :password => "foobar",
										  		 :provider => 'google_oauth2',
    											 :uid => '123567')
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  		get 'createoauth'
			session[:user_id].should eq @user.id
			response.should redirect_to root_path
		end

		it 'should be able to find the user if they have signed in before with twitter' do
			@user = User.create( :username => 'something',
										  		 :email => "foo@bar.com",
										  		 :password => "foobar",
										  		 :provider => 'twitter',
    											 :uid => '987654')
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  		get 'createoauth'
			session[:user_id].should eq @user.id
			response.should redirect_to root_path
		end
	end
end