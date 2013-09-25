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
  						:longitude => -87.677845
  	}
  	expect{
  		Restaurant.create(@attr)
  	}.to change(Restaurant, :count).by(1)
  end
end
