require 'spec_helper'
include UserHelper

describe PhotosController do
  
  describe "POST #create" do
    before(:each) do
      @restaurant = FactoryGirl.create(:restaurant)
      @dish = @restaurant.dishes.first
      @photo = Photo.new()
    end

    context "when logged in" do  
      before(:each) do
        user_login
        controller.stub(:current_user).and_return(double(:id => 1))       
      end

      it "assigns the photo's dish to @dish" do
        post :create, photo: { :dish_id => @dish.id, :user_id => 1 }
        assigns(:dish).should eq(@dish)
      end

      context "when dish is found" do
        it "assigns the photo's restaurant to @restaurant" do
          post :create, photo: { :dish_id => @dish.id, :user_id => 1 }
          assigns(:restaurant).should eq(@restaurant)
        end

        context "on successful save" do
          before(:each) do
            Photo.any_instance.stub(:save).and_return(true)
            post :create, photo: { :dish_id => @dish.id, :user_id => 1 }
          end

          it "should redirect to the same page" do
            response.should redirect_to("/#{@restaurant.url}/#{@dish.url}")
          end

          it "should flash success message" do
            flash.now[:success].should =~ /Photo added/
          end
        end

        context "on unsuccessful save" do
          before(:each) do
            Photo.any_instance.stub(:save).and_return(false)
            post :create, photo: { :dish_id => @dish.id, :user_id => 1 }
          end
          it "should redirect to the same page" do
            response.should redirect_to("/#{@restaurant.url}/#{@dish.url}")
          end

          it "should flash error message" do
            flash.now[:error].should =~ /choose an image/
          end
        end
      end

      context "when dish is not found" do
        before(:each) do
          post :create, photo: { :dish_id => 99999, :user_id => 1 }
        end

        it "should redirect to the same page" do
          response.should redirect_to restaurants_path
        end

        it "should flash error message" do
          flash.now[:error].should =~ /Dish was not found/
        end
      end
    end

    context "when logged out" do
      before(:each) do
        post :create, photo: { :dish_id => @dish.id, :user_id => 1 }
      end

      it "should redirect you to root path" do
        response.should redirect_to root_path
      end

      it "should flash error asking user to log in" do
        flash.now[:error].should =~ /Please log in/
      end
    end
  end
end