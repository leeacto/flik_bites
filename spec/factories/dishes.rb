FactoryGirl.define do 
  factory :dish do |f|
    f.name        "Pad Thai"
    f.category    "Entree"
    f.description "Thai noodles with peanuts and stuff"
    f.price       "10.00"
    f.url         "padthai"
  end

  factory :invalid_dish, :parent => :dish do |f|
    f.category nil
  end

  factory :no_name_dish, :parent => :dish do |f|
    f.category nil
  end
end