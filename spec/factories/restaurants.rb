FactoryGirl.define do 
  factory :restaurant do |f|
    f.name        "The Bristol"
    f.address     "2152 N. Damen Ave"
    f.city        "Chicago"
    f.state       "IL"
    f.zip         60647
    f.cuisine     "American"
    f.latitude    41.921109
    f.longitude   -87.677845
    f.url         "thebristol"

    f.dishes      { [ FactoryGirl.create(:dish) ] }
  end
end
