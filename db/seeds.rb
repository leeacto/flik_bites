
#Seed Two Restaurants
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

@attr_3 = { :name => "Pizza Hut", 
						:address => "1414 N Milwaukee Ave",
						:city => "Chicago",
						:state => "IL",
						:zip => 60622,
						:cuisine => "Classic American",
						:latitude => 42.298697,
						:longitude => -87.956501,
						:url => 'pizzahut'
}

@attr_4 = { :name => "Taco Bell", 
						:address => "1414 N Milwaukee Ave",
						:city => "Chicago",
						:state => "IL",
						:zip => 60622,
						:cuisine => "Traditional Mexican",
						:latitude => 42.298697,
						:longitude => -87.956501,
						:url => 'tacobell'
}

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


a = Restaurant.create(@attr)
b = Restaurant.create(@attr_t)
c = Restaurant.create(@attr_3)
d = Restaurant.create(@attr_4)


a.dishes.create(@dish_attr)
a.dishes.create(@dish_attr2)
b.dishes.create(@dish_attr)
b.dishes.create(@dish_attr2)
c.dishes.create(@dish_attr)
c.dishes.create(@dish_attr2)
d.dishes.create(@dish_attr)
d.dishes.create(@dish_attr2)

