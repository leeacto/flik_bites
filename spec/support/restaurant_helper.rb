module RestaurantHelper
  def one_rest
    @dish_attr = { :name => "pad thai",
               :category => "Entree",
               :description => "Thai noodles with peanuts and stuff",
               :price => "10.00",
               :url => "padthai"
              }

    @dish_attr2 = { :name => "pizza",
               :category => "Entree",
               :description => "Slice of heaven",
               :price => "2.00",
               :url => "pizza"
              }
    a = FactoryGirl.create(:restaurant)
    a.dishes.create(@dish_attr)
    a.dishes.create(@dish_attr2)
    a
  end

  def two_rest
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
    @attr_t = { :name => "Cumin", 
                :address => "1414 N Milwaukee Ave",
                :city => "Chicago",
                :state => "IL",
                :zip => 60622,
                :cuisine => "Indian / Nepalese",
                :latitude => 42.298697,
                :longitude => -87.956501,
                :url => 'cumin'
               }
    @dish_attr = { :name => "pad thai",
               :category => "Asian",
               :description => "Thai noodles with peanuts and stuff",
               :price => "10.00",
               :url => "padthai"
              }

    @dish_attr2 = { :name => "pizza",
               :category => "Pizza",
               :description => "Slice of heaven",
               :price => "2.00",
               :url => "pizza"
              }
              
    a = Restaurant.create(@attr)
    a.dishes.create(@dish_attr)
    a.dishes.create(@dish_attr2)

    b = Restaurant.create(@attr_t)
    b.dishes.create(@dish_attr)
    b.dishes.create(@dish_attr2)

    [a, b]
  end
end