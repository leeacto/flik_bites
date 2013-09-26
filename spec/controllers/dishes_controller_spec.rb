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

  describe "GET #edit" do
    it "renders the :edit template" do
      get :edit, :restname => "theBristol", :dishname => "pad Thai"
      response.should render_template :edit
    end
    
    it "should prepare to edit the correct dish" do
      get :edit, :restname => "theBristol", :dishname => "pad Thai"
      assigns(:dish).should eq(@restaurant.dishes.first)
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

  describe "PUT update" do
    before(:each) do
      @dish = FactoryGirl.create(:dish, :name => "Salad", 
                                        :price => "7.00")
    end

    context "with valid attributes" do
      it "locates requested @dish" do
        put :update, :id => @dish, 
            :dish => FactoryGirl.attributes_for(:dish) 
        assigns(:dish).should eq(@dish)
      end

      it "changes @dish's attributes" do
        put :update, :id => @dish,
            :dish => FactoryGirl.attributes_for(:dish, :name => "Pizza", 
                                                       :price => "2.00")
        @dish.reload
        @dish.name.should eq("Pizza")
        @dish.price.should eq("2.00")
      end

      it "redirects to the updated dish" do
        put :update, :id => @dish, 
            :dish => FactoryGirl.attributes_for(:dish) 
        response.should redirect_to @dish        
      end
    end

    context "with invalid attributes" do
      it "locates requested @dish" do
        put :update, :id => @dish, 
            :dish => FactoryGirl.attributes_for(:invalid_dish)
        assigns(:dish).should eq(@dish)         
      end

      it "does not change @dish's attributes" do
        put :update, :id => @dish,
            :dish => FactoryGirl.attributes_for(:dish, :name => nil)
        @dish.reload
        @dish.name.should eq("Salad")
      end

      it "re-renders the edit template" do
        put :update, :id => @dish,
            :dish => FactoryGirl.attributes_for(:invalid_dish)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @dish = @restaurant.dishes.first
    end

    it "deletes the dish" do
      expect { delete :destroy, :id => @dish }.to change(Dish, :count).by(-1)
    end

    it "redirects to the restaurant menu" do
      delete :destroy, :id => @dish
      response.should redirect_to @restaurant
    end
  end
end







