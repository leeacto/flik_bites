require 'nokogiri'
require 'mechanize'
require 'csv'

class RestaurantList
  attr_reader :rest_list

  # take an allmenus url and scrape through restaurants / menu pages
  def initialize(url)
  	@url = url
    @agent = Mechanize.new
    @page = @agent.get(url)
    @noko_page = Nokogiri::HTML(@page.body)

    @rest_list = self.get_names.zip(self.get_cuisines, self.get_addresses)
    save_to_csv
  end

  def get_names
    @noko_page.search('.restaurant_name').map { |link| link.inner_text }  
  end

  def get_cuisines
    @noko_page.search('.restaurant_cuisines').map { |link| link.inner_text.strip }  
  end

  def get_addresses
    @noko_page.search('.restaurant_address').map { |link| link.inner_text }  
  end

  def parse_address(full_addr)
  	#split full address into [address, city, zip]
  	first_split = full_addr.split(",")
  	address = first_split[0]
  	city = first_split[1].match(/[a-z\s]+/i).to_s.strip
  	zip = first_split[1].match(/\d+/).to_s.strip
  	return [address, city, zip]
  end

  def get_numbers
  	#NUMBERS ARE ON ACTUAL RESTAURNT MENU PAGE
    @noko_page.search('#phone_number').inner_text
  end
  
  def save_to_csv
  	rest_id = 1
  	@rest_list.each do |rest|
  		address_array = parse_address(rest[2])

	  	CSV.open("db/restaurants.csv", "ab") do |csv|
	  		csv << [ rest_id, rest[0], address_array[0], address_array[1], 
	  						 "IL", address_array[2], rest[1], rest[0].gsub(/\W/, "").downcase ]
	  	end
	  	rest_id += 1
	  end
  end

  def get_menus
  	rest_id = 1
  	@rest_list.each do |rest|
  		agent = Mechanize.new
  		page = agent.get(@url)
  		menu_page = agent.page.link_with(:text => rest[0]).click.body
  		Menu.new(menu_page, rest_id)
  		p rest_id += 1
  	end
  end
end

class Menu
	def initialize(raw_html, rest_id)
		@page = Nokogiri::HTML(raw_html)
		save_to_csv(rest_id)
	end

  def save_to_csv(rest_id)
    @page.search('.category').each do |div|
      div.search('ul li').each do |li|

    		category = div.search('.category_head > h3').inner_text
    		name = li.search('.name').inner_text
    		price = li.search('.price').inner_text
    		description = li.search('.description').inner_text      	

      	CSV.open("db/menus.csv", "ab") do |csv|
      		csv << [ rest_id, category, name, price, description ]
      	end
      end
    end
  end
end

# url = 'http://www.allmenus.com/il/chicago/-/'
# chicago_500 = RestaurantList.new(url)
# chicago_500.get_menus

# restaurant_url = 'http://www.allmenus.com/il/chicago/185647-grand-lux-cafe/menu/'
# test = Menu.new(restaurant_url, 1)


