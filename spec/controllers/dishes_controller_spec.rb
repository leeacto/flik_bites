require 'spec_helper'


describe DishesController do 

  describe "GET #index" do

    it "renders the :index view" do
      restaurant = FactoryGirl.create(:restaurant)
      
      get :index
      response.should render_template :index
    end

    it "populates an array of dishes" do
      restaurant = FactoryGirl.create(:restaurant)
      restaurant.name.should equal("The Bristol")   
      # get :index, :restname => "theBristol"
      # assigns(:restaurant).should eq(restaurant)
    end

    describe "GET #show" do
      it "assigns the requested dish to @dish"

      it "renders the :show template"
    end

    describe "POST #create" do 
      context "with valid attributes" do
        it "saves the new dish in the database"
        it "redirects to the restaurant menu page"
      end

      context "with invalid attributes" do
        it "does not save dish in the database"
        it "re-renders the dish :new template"
      end
    end
  end
end