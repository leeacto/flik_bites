require 'spec_helper'
include UserHelper
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
      page.should have_content 'Username'
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
    fill_in 'session_username', with: 'username'
    fill_in 'session_password', with: 'password'
    click_button 'Login'
    click_link 'Logout'
    current_path.should eq root_path
  end
end