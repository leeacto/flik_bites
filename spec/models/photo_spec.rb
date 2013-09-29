require 'spec_helper'

describe Photo do

  it "validates that the photo has an attachment" do
    Photo.create(:user_id => 1, :dish_id => 1, :image => nil).should_not be_valid
  end

end

