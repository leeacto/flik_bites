module RestaurantsHelper
	def street_city(rest)
		rest.address + " " + rest.city
	end
end