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

feature 'Deactivate User' do
	before(:each) do
	end

	it "should see a deactivate account link" do
		pending
	end
end