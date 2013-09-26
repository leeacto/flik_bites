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
      @dish = @restaurant.dishes.first
      assigns(:dish).should eq(@dish)
    end

    it "renders the :show template" do
      response.should render_template :show
    end

  end

  describe "GET #new" do
    it "assigns the dish's restaurant to @restaurant" do
      get :new, :restname => "theBristol"
      assigns(:restaurant).should eq(@restaurant)
    end

    it "renders the :new template" do
      get :new, :restname => "theBristol"
      response.should render_template :new
    end
  end

  describe "POST #create" do 
    context "with valid attributes" do
      it "saves the new dish in the database" do
        expect { post :create, :restname => "thebristol",
                      :dish => FactoryGirl.attributes_for(:dish)
                }.to change(Dish, :count).by(1) 
      end

      it "redirects to the restaurant menu page" do 
        post :create, :restname => "thebristol",
                      :dish => FactoryGirl.attributes_for(:dish)
        response.should redirect_to @restaurant
      end
    end

    context "with invalid attributes" do
      it "does not save dish in the database" do
        expect { post :create, :restname => "thebristol",
                      :dish => FactoryGirl.attributes_for(:invalid_dish)
                }.to_not change(Dish, :count)         
      end

      it "re-renders the dish :new template" do
        post :create, :restname => "thebristol",
                      :dish => FactoryGirl.attributes_for(:invalid_dish)
        response.should render_template :new       
      end
    end
  end
end