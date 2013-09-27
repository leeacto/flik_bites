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

@dish_attr3 = { :name => "burger",
							 :category => "Entree",
							 :description => "MM meat",
							 :price => "5.00",
							 :url => "burger"
}

@dish_attr4 = { :name => "salad",
							 :category => "appetizer",
							 :description => "pre food",
							 :price => "6.00",
							 :url => "salad"
}



a = Restaurant.create(@attr)
b = Restaurant.create(@attr_t)

a.dishes.create(@dish_attr)
a.dishes.create(@dish_attr2)
a.dishes.create(@dish_attr3)
a.dishes.create(@dish_attr4)


b.dishes.create(@dish_attr)
b.dishes.create(@dish_attr2)
b.dishes.create(@dish_attr3)
b.dishes.create(@dish_attr4)



