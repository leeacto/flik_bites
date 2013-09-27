require 'spec_helper'

describe "Sessions" do
	before(:each) do
		one_user
		visit login_path
	end

	context "with valid user/pass" do
		it "should allow for successful login" do
			fill_in 'session_username', with: 'username'
			fill_in 'session_password', with: 'password'
			click_button 'Login'
			page.should have_content 'Profile'
		end
	end

	context "with invalid user/pass" do
		it "should not allow access" do
			fill_in 'session_username', with: 'username'
			fill_in 'session_password', with: 'password1'
			click_button 'Login'
			page.should have_content 'incorrect'
		end
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