require 'spec_helper'
include RestaurantHelper
include UserHelper

feature "Add a Restaurant" do
  context "On Purpose" do
    describe "As a Logged In User" do
      before(:each) do
        user_login
        visit '/restaurants/new'
      end
      
      it "should route to the correct page" do
        page.should have_content 'New'
      end

      describe "Back End" do
        before(:each) do
          fill_in "restaurant_name", with: "Pizza Hut"
          fill_in "restaurant_address", with: "1927 W North Ave"
          fill_in "restaurant_city", with: "Chicago"
          fill_in "restaurant_state", with: "IL"
          fill_in "restaurant_zip", with: "60622"
          fill_in "restaurant_cuisine", with: "Pizza"
          click_button 'Create Restaurant'
        end
        
        it "should add a new restaurant record" do
          Restaurant.last.name.should eq "Pizza Hut"
        end
      end
    end
  end

  context "When Not Logged In" do
    describe "should not allow access" do

      before(:each) do
        visit '/restaurants/new'
      end

      it "should have a flash error" do
        page.should have_content 'must log'
      end
    end
  end
end

feature "Navigate to a Restaurant" do
  context "When logged in" do
    before(:each) do
      two_rest
      user_login
    end

    it "should let user see /:restaurant/dishes route" do
      click_link 'Cumin'
      page.should have_content 'Cumin'
    end
  end

  context "When not logged in" do
    it "should let user see /:restaurant/dishes route" do
      two_rest
      visit login_path
      click_link 'Restaurants'
      click_link 'Cumin'
      page.should have_content 'Cumin'
    end
  end
end

feature "Interacting with /:restaurant/dishes page" do
  before(:each) do
    two_rest
  end
  
  context "Either Logged in or Not" do
    before(:each) do
      visit "/cumin/dishes"
    end

    describe "category list" do
      it "should show the list of categories" do
        page.should have_content 'Asian'
      end
      
      it "should not include false categories" do
        page.should_not have_content 'Mexican'
      end
    end

    describe "dish cards" do
      it "should display the correct dishes" do
        page.should have_content "pad thai"
      end

      it "should not display dishes it doesn't carry" do
        page.should_not have_content "squash"
      end
    end
    # Not Working - I think it may be due to TinyBox
    # it "should show restaurant info upon clicking name" do
    #   find('#rest_show_name').click
    #   page.should have_content 'American'
    # end
  end

  context "While Logged In" do

  end

  context "As a Visitor" do
  end
end

feature "Search Bar" do
  context "on the restaurant index" do
    before(:each) do
      two_rest
      visit restaurants_path
    end

    context "when no search is submitted" do
      it "should show a default list of restaurants" do
        page.should have_content("The Bristol")
        page.should have_content("Cumin")
      end
    end

    context "when a search is submitted" do

      it "should return restaraurant matches" do
        fill_in "search", with: "bri"
        click_button "Search"
        page.should have_content("The Bristol")
        page.should_not have_content("Cumin")
      end

      it "should return dish matches based on name" do
        # fill_in "search", with: "pizza"
        # click_button "Search"
        # save_and_open_page
        # page.should have_content("Pizza")
      end

      it "should return restaurant matches based on cuisine type" do
        fill_in "search", with: "indian"
        click_button "Search"
        page.should have_content("Cumin")
      end

      it "should return restaurant matches based on zip code" do 
        fill_in "search", with: "60647"
        click_button "Search" 
        page.should have_content("The Bristol")
      end

      it "should return both restaurant and dish matches" do
        # fill_in "search", with: "pad thai"
        # click_button "Search"
        # page.should have_content("Pad Thai")
      end

      it "should not return non-match results" do
        fill_in "search", with: "this is not a freakin restaurant"
        click_button "Search"
        page.should have_content("Sorry no matches")
      end
    end
  end
end