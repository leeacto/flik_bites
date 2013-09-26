require 'spec_helper'
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
		  		:password => "foobar",
		  		:password_confirmation => "foobar"
		  	}
		  end

		 	it "should create a new instance given valid attributes" do
		  	 expect { User.create!(@attr) }.to change(User, :count).by(1)
		  end

		  it "should not be able to create without valid input" do
		  	User.create(:username => "TestUserName",
		  		:first_name => "TestFirst", 
		  		:last_name => "TestLast", 
		  		:zipcode => "60060", 
		  		:email => "user@eample.com",
		  		:password => "fooar",
		  		:password_confirmation => "foobar")
		  		response.should render_template '/'
		  end
		end
	end
end