require 'spec_helper'

describe "Sessions" do
	it "should be able to log in a user that is active" do
		User.create!(:username => "TestUserName",
							  		 :first_name => "TestFirst", 
							  		 :last_name => "TestLast", 
							  		 :zipcode => "60060", 
							  		 :email => "user@example.com",
							  		 :password => "foobar",
							  		 :password_confirmation => "foobar")
		visit ('/login')
		fill_in 'session_username', with: 'TestUserName'
		fill_in 'session_password', with: "foobar"

		click_button 'Login'

		current_path.should eq root_path
	end

	it "should be able to log out a user" do
		User.create!(:username => "TestUserName",
							  		 :first_name => "TestFirst", 
							  		 :last_name => "TestLast", 
							  		 :zipcode => "60060", 
							  		 :email => "user@example.com",
							  		 :password => "foobar",
							  		 :password_confirmation => "foobar")
		visit ('/login') 
		fill_in 'session_username', with: 'TestUserName'
		fill_in 'session_password', with: "foobar"

		click_button 'Login'

		visit ('/logout')

		current_path.should eq root_path
	end
end