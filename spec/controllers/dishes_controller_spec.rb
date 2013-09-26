require 'spec_helper'


describe DishesController do 

  before(:each) do
    @restaurant = FactoryGirl.create(:restaurant)
  end

  describe "GET #index" do

    before(:each) do
      get :index, :restname => "theBristol"
    end
    
    it "renders the :index view" do
      response.should render_template :index
    end

    it "assigns the requested restaurant to @restaurant" do
      assigns(:restaurant).should eq(@restaurant)
    end

    it "populates an array of dishes" do   
      assigns(:dishes).should eq(@restaurant.dishes)
    end
  end

  describe "GET #show" do

    before(:each) do
      get :show, :restname => "theBristol", :dishname => "Pad Thai"
    end

    it "assigns the requested dish to @dish" do
      assigns(:dish).should eq()
    end

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