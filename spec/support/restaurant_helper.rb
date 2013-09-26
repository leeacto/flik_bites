module RestaurantHelper

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
    a = Restaurant.create(@attr)
    b = Restaurant.create(@attr_t)
    [a, b]
	end
end