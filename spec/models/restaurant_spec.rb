require 'spec_helper'

describe Restaurant do
  it "should be able to create a new instance" do
    @attr = { :name => "The Bristol", 
              :address => "2152 N. Damen Ave",
              :city => "Chicago",
              :state => "IL",
              :zip => 60647,
              :cuisine => "American",
              :latitude => 41.921109,
              :longitude => -87.677845,
              :url => 'thebristol'
    }
    expect{
      Restaurant.create(@attr)
    }.to change(Restaurant, :count).by(1)
  end

  describe ".search" do

    let!(:restaurant) { FactoryGirl.create(:restaurant) }

    context "works for exact matches" do

      it "on restaurant name" do
        Restaurant.search("The Bristol").first.should eq(restaurant)
      end
    end

    context "works for partial matches" do
      
      it "on restaurant name" do
        Restaurant.search("The").first.should eq(restaurant)
      end
    end

    context "works for partial matches ending with search term" do
      
      it "on restaurant name" do
        Restaurant.search("ol").first.should eq(restaurant)
      end

    end

    context "works for partial matches inside with search term" do
      
      it "on restaurant name" do
        Restaurant.search("Bri").first.should eq(restaurant)
      end

    end

    it "is case insensitive" do
      Restaurant.search("bristol").first.should eq(restaurant)
    end

    it "should return an empty array if no matches" do
      Restaurant.search("no restaurant").should eq([])
    end

    it "should strip spaces off search term" do
      Restaurant.search("      Bristol    ").first.should eq(restaurant)
    end

  end

end
