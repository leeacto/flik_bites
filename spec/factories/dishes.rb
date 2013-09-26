FactoryGirl.define do 
  factory :dish do |f|
    f.name        "Pad Thai"
    f.category    "Entree"
    f.description "Thai noodles with peanuts and stuff"
    f.price       "10.00"
  end
end