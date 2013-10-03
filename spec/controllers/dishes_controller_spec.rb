require 'spec_helper'
include UserHelper

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
      assigns(:dishes).should =~ @restaurant.dishes
    end

    it "lists the categories for the dishes" do
      assigns(:categories).should eq(@restaurant.dishes.pluck(:category).uniq)
    end
  end

  describe "GET #new" do
    context "as a signed in user" do
      before(:each) do
        user_login
        controller.stub(:current_user).and_return true
      end

      it "assigns the dish's restaurant to @restaurant" do
        get :new, :restname => "theBristol"
        assigns(:restaurant).should eq(@restaurant)
      end

      it "renders the :new template" do
        get :new, :restname => "theBristol"
        response.should render_template :new
      end
    end

    context "when not logged in" do
      it "should flash error message" do
        get :new, :restname => "theBristol"
        flash.now[:error].should =~ /log in/
      end

      it "should return to root path" do
        get :new, :restname => "theBristol"
        response.should redirect_to restaurants_path
      end
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

    it "renders not_found page if dish is nil" do
      get :show, :restname => "theBristol", :dishname => "not a dish"
      response.should render_template :not_found
    end
  end

  describe "GET #edit" do
    context "as a logged in user" do
      before(:each) do
        user_login
        controller.stub(:current_user).and_return true
      end

      it "renders the :edit template" do
        get :edit, :restname => "theBristol", :dishname => "pad Thai"
        response.should render_template :edit
      end
      
      it "should prepare to edit the correct dish" do
        get :edit, :restname => "theBristol", :dishname => "pad Thai"
        assigns(:dish).should eq(@restaurant.dishes.first)
      end

      it "renders not_found page if dish is nil" do
        get :edit, :restname => "theBristol", :dishname => "not a dish"
        response.should render_template :not_found
      end
    end

    context "as a logged out user" do
      it "redirects user back to restaurants_path" do
        delete :destroy, :id => @dish
        response.should redirect_to restaurants_path
      end

      it "should flash error message" do
        delete :destroy, :id => @dish
        flash.now[:error].should =~ /log in/
      end
    end
  end

  describe "POST #create" do 
    describe "as a logged in user" do
      before(:each) do
        user_login
        controller.stub(:current_user).and_return true
      end
    
      context "with valid attributes" do
        it "saves the new dish in the database" do
          expect { post :create,
                        :dish => FactoryGirl.attributes_for(:dish, :name => "Taco", :restname => "thebristol")
                  }.to change(Dish, :count).by(1)
        end

        it "gets a success flash" do
          post :create,
                        :dish => FactoryGirl.attributes_for(:dish, :name => "Taco", :restname => "thebristol")
          flash.now[:success].should =~ /New Dish Added!/
        end

        it "redirects to the restaurant menu page" do 
          post :create,
                        :dish => FactoryGirl.attributes_for(:dish, :name => "Taco", :restname => "thebristol")
          response.should redirect_to "/#{@restaurant.url}/taco"
        end
      end

      context "with invalid attributes" do
        describe "no name" do
          it "shows a no-name error" do 
            post :create,
                          :dish => FactoryGirl.attributes_for(:dish, :name => nil, :restname => "thebristol")
            flash.now[:error].should =~ /Name/i
          end
        end

        describe "no category" do
          it "does not save dish in the database" do
            expect { post :create,
                          :dish => FactoryGirl.attributes_for(:invalid_dish, :name => "Taco", :restname => "thebristol")
                    }.to_not change(Dish, :count)         
          end

          it "re-renders the dish :new template" do
            post :create,
                          :dish => FactoryGirl.attributes_for(:invalid_dish, :name => "Taco", :restname => "thebristol")
            response.should render_template :new       
          end
        end
      end
    end

    describe "as a non-logged in viewer" do
      it "should flash error message" do
        post :create,
                        :dish => FactoryGirl.attributes_for(:dish, :restname => "thebristol")
        flash.now[:error].should =~ /log in/
      end

      it "should return to restaurants page" do
        post :create,
                        :dish => FactoryGirl.attributes_for(:dish, :restname => "thebristol")
        response.should redirect_to restaurants_path
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @dish = FactoryGirl.create(:dish, :name => "Salad", 
                                        :price => "7.00")
    end

    context "as a logged in user" do
      before(:each) do
        user_login
        controller.stub(:current_user).and_return true
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

    context "as a logged out user" do
      it "redirects user back to restaurants index" do
        delete :destroy, :id => @dish
        response.should redirect_to restaurants_path
      end

      it "should flash error message" do
        delete :destroy, :id => @dish
        flash.now[:error].should =~ /log in/
      end
    end

    
  end

  describe "DELETE destroy" do
    before(:each) do
      @dish = @restaurant.dishes.first
    end

    context "as a logged in user" do
      before(:each) do
        user_login
        controller.stub(:current_user).and_return true
      end

      it "deletes the dish" do
        expect { delete :destroy, :id => @dish }.to change(Dish, :count).by(-1)
      end

      it "redirects to the restaurant menu" do
        delete :destroy, :id => @dish
        response.should redirect_to @restaurant
      end
    end

    context "as a logged out user" do
      it "redirects user back to restaurants path" do
        delete :destroy, :id => @dish
        response.should redirect_to restaurants_path
      end

      it "should flash error message" do
        delete :destroy, :id => @dish
        flash.now[:error].should =~ /log in/
      end
    end

  end
end







