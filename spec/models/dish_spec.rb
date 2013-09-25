require 'spec_helper'

describe Dish do

  before(:each) do
    @dish = FactoryGirl.create(:dish)
  end

  it "has a valid factory" do
    @dish.should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:dish, :name => nil).should_not be_valid
  end

  it "is invalid without a category" do
    FactoryGirl.build(:dish, :category => nil).should_not be_valid
  end

  it "should respond to photos" do
    @dish.should respond_to(:photos)
  end

  it "should respond to a restaurant" do
    @dish.should respond_to(:restaurant)
  end

end
