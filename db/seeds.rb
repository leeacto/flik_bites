require 'nokogiri'
require 'mechanize'
require 'csv'

class RestaurantList
  attr_reader :rest_list

  # take an allmenus url and scrape through restaurants / menu pages
  def initialize(url)
    @agent = Mechanize.new
    @page = @agent.get(url)
    @noko_page = Nokogiri::HTML(@page.body)
    @link_list = []

    @rest_list = self.get_names.zip(self.get_cuisines, self.get_addresses)
    p self.save_to_csv
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
  	@rest_list.each do |rest|
  		address_array = parse_address(rest[2])

	  	CSV.open("db/restaurants.csv", "ab") do |csv|
	  		csv << [ rest[0], address_array[0], address_array[1], 
	  						 "IL", address_array[2], rest[1], rest[0].gsub(" ", "").downcase ]
	  	end
	  end
  end

  # def create_restaurants
  #   @rest_list.map! do |rest|
  #   	address_array = parse_address(rest[2])

  #     Restaurant.create({ name: rest[0], 
  #     										address: address_array[0], 
  #     										city: address_array[1],
  #     										state: "IL",
  #     										zip: address_array[2], 
  #     										cuisine: rest[1],
  #     										url: rest[0].gsub(" ", "").downcase
  #     									})
  #   end
  # end
end


url = 'http://www.allmenus.com/il/chicago/-/'
a = RestaurantList.new(url)
