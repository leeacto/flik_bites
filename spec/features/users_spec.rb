require 'spec_helper'

feature 'Create User Form' do
	it "should show a user create form" do
		visit new_user_path
		page.should have_content "Username"
	end
end

feature 'Create User' do
	it "should save to database" do
		visit new_user_path
		expect {
			fill_in 'user_first_name', with: 'first'
			fill_in 'user_last_name', with: 'last'
			fill_in 'user_zipcode', with: '60060'
			fill_in 'user_username', with: 'username'
			fill_in 'user_email', with: "email@email.com"
			fill_in 'user_password', with: "password"
			fill_in 'user_password_confirmation', with: "password"
			click_button 'Create User'
		}.to change(User, :count).by(1)
	end
end

feature 'Edit user information' do 
	before(:each) do
			@user = User.create!(:username => "TestUserName",
										  		 :first_name => "TestFirst", 
										  		 :last_name => "TestLast", 
										  		 :zipcode => "60060", 
										  		 :email => "user@example.com",
										  		 :password => "foobar",
										  		 :password_confirmation => "foobar")
		visit "/login"
		fill_in 'session_username', with: 'TestUserName'
		fill_in 'session_password', with: "foobar"

		click_button 'Login'
	end
	it "should see a deactivate account link" do
	

		visit '/users/TestUserName'

		page.should have_content "deactivate account"
	end

	it "user shour see the edit information link" do
		visit '/users/TestUserName'

		page.should have_content "Edit Profile "
	end

	it 'should be able to edit their own information' do
		visit '/users/TestUserName'
		click_link 'Edit Profile'
		fill_in 'user_first_name', with: 'change'
		fill_in 'user_last_name', with: "this"
		fill_in 'user_username', with: "username"
		click_button 'Edit User'
		@user.reload

		@user.first_name.should eq 'change'
		@user.last_name.should eq 'this'
		@user.username.should eq 'username'
		current_path.should eq '/users/username'
	end
end
