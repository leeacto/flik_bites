module RestaurantsHelper
	def street_city(rest)
    
		formatted = rest.address + " " + rest.city
    formatted
	end
end