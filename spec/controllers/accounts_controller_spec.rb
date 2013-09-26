require 'spec_helper'

describe AccountsController do

	it "should be able to deactive a user" do
		@user = User.create(:username => "TestUserName",
										  		 :first_name => "TestFirst", 
										  		 :last_name => "TestLast", 
										  		 :zipcode => "60060", 
										  		 :email => "user@example.com",
										  		 :password => "foobar",
										  		 :password_confirmation => "foobar")
		post :update,{format: "#{@user.id}"}
		@user.reload.is_active?.should eq false
		session[:user_id].should eq nil
		response.should redirect_to(root_path)	
	end

	it "should be able to re-active a user" do
		@user = User.create(:username => "TestUserName",
										  		 :first_name => "TestFirst", 
										  		 :last_name => "TestLast", 
										  		 :zipcode => "60060", 
										  		 :email => "user@example.com",
										  		 :password => "foobar",
										  		 :password_confirmation => "foobar",
										  		 :is_active => false)
		post :update,{format: "#{@user.id}"}
		@user.reload.is_active?.should eq true
		response.should redirect_to(login_path)
	end

end