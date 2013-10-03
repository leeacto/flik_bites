require 'spec_helper'
include UserHelper
include RestaurantHelper
feature 'Create User Form' do
  it "should show a user create form" do
    visit new_user_path
    page.should have_content "Create User"
  end
end

feature 'Create User' do
  it "if user fills out with propper info should save" do
    visit new_user_path
    expect {
            fill_in 'user_username', with: 'username'
            fill_in 'user_email', with: "email@email.com"
            fill_in 'user_password', with: "password"
            click_button 'Create User'
          }.to change(User, :count).by(1)
  end
end

feature 'Edit user information' do 
  before(:each) do
    @user = one_user
    visit login_path
    fill_in 'session_username', with: 'username'
    fill_in 'session_password', with: "password"
    click_button 'Login'
  end

  it "should see a deactivate account link" do
    click_link 'Username'
    page.should have_content "Deactivate Account"
  end

  it "user should see the edit information link" do
    click_link 'Username'
    page.should have_content "Edit Profile "
  end

  it 'should be able to edit their own information' do
    click_link 'Username'
    click_link 'Edit Profile'
    fill_in 'user_first_name', with: 'change'
    fill_in 'user_last_name', with: "this"
    fill_in 'user_username', with: "username2"
    click_button 'Edit User'
    @user.reload

    @user.first_name.should eq 'change'
    @user.last_name.should eq 'this'
    @user.username.should eq 'username2'
    current_path.should eq '/users/username2'
  end
end

feature 'User should be able to star a restaurant and dish and view profile' do
  before(:each) do
    @rest = one_rest
    @user = one_user
    visit login_path
    fill_in 'session_username', with: 'username'
    fill_in 'session_password', with: "password"
    click_button 'Login'
  end

  it 'star a restaurant' do
    visit restaurants_path
    page.should have_content 'The Bristol'
    find(".ustar").click
    page.should have_content 'The Bristol'
  end

  it 'star a dish' do
    visit restaurants_path
    click_link 'The Bristol'
    page.should have_content "#{@rest.dishes.first.name}"
    page.first('.ustar').click
    page.should have_content "#{@rest.dishes.first.name}"
  end

  it 'should be able to visit their favorites page' do
    visit restaurants_path
    click_link 'My Favorites'
    page.should have_content 'My Starred Restaurants'
    page.should have_content 'My Starred Dishes'
  end
end