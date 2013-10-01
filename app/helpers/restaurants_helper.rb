module RestaurantsHelper
  def street_city(rest)
    formatted = rest.address + " " + rest.city
  end

  def gsearch(rest)
    gsrch = rest.name + " " + rest.address + " " + rest.city
    gsrch.gsub(" ","+").gsub('\'','').gsub('&','').gsub('++','+')
  end
end