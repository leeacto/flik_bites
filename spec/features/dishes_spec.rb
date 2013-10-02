require 'spec_helper'
include RestaurantHelper
include UserHelper

feature "Adding a Dish" do
  context "As a Logged In User" do
    before(:each) do
      two_rest
      user_login
    end

    it "should access the add dish page" do
      # click_link 'Cumin'
      # click_link 'Add a Dish'
      # page.should have_content 'Add a Dish to Cumin'
    end

    describe "with valid attributes" do
      before(:each) do
        click_link 'Cumin'
        click_link 'Add a Dish'
      end

      it "should create a new dish" do
        # expect {
        #   fill_in 'dish_name', with: 'taco'
        #   choose 'dish_category_entree'
        #   fill_in 'dish_description', with: 'it a taco'
        #   fill_in 'dish_price', with: '2.00'
        #   click_button 'Create Dish'
        # }.to change(Dish, :count).by(1)
      end

      it "should deny repeat dish names" do
        # expect {
        #   fill_in 'dish_name', with: 'pizza'
        #   choose 'dish_category_entree'
        #   fill_in 'dish_description', with: 'cmon'
        #   fill_in 'dish_price', with: '2.00'
        #   click_button 'Create Dish'
        # }.not_to change(Dish, :count)
      end
    end
  end
  
  context "As a Non-Logged In Viewer" do
    describe "will deny access" do
      before(:each) do
        two_rest
      end
      
      it "should ask user to login first" do
        visit '/restaurants'
        click_link 'Cumin'
        click_link 'Add a Dish'
        page.should have_content "Please log in"  
      end
    end
  end
end

feature "Search Bar" do
  context "on the dishes index" do
    before(:each) do
      two_rest
      visit "/cumin/dishes"
    end

    context "when no search is submitted" do
      it "should show the first category of dishes" do
        save_and_open_page
        page.should have_content "Asian"
      end
    end
    
    context "when a search is submitted" do
      it "should return dish matches based on dish name" do
        fill_in "search", with: "piz"
        click_button "Search"
        page.should have_content "pizza"
      end

      it "should return dish matches based on dish category" do
        fill_in "search", with: "asian"
        click_button "Search"
        page.should have_content "pad thai"
      end

      it "should not return non-match results" do
        fill_in "search", with: "piz"
        click_button "Search"
        page.should_not have_content "Pad Thai"
      end
    end   
  end
end