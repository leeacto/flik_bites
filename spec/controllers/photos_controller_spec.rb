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
        controller.stub(:current_user).and_return @user       
      end

      it "assigns the photo's dish to @dish" do
        post :create, :photo => {:dish_id => @dish.id}
        assigns(:dish).should eq(@dish)
      end

      it "assigns the photo's restaurant to @restaurant"

      context" when successful" do
        before(:each) do
          Photo.any_instance.stub(:save_attached_files).and_return(true)
          @photo = FactoryGirl.create :photo
          @photo.stub(:save).and_return(true)
        end

        it "should redirect to the same page"

        it "should flash success message" 
      end

      context "when unsuccessful" do
        it "should redirect to the same page" 

        it "should flash error message" do
        end
      end
    end

    context "when logged out" do
      before(:each) do
        # controller.stub(:logged_in?).and_return false
      end

      it "should redirect you to the same page" 

      it "should flash error asking user to log in" 
    end
  end

end