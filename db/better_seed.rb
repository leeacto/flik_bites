require 'nokogiri'
require 'mechanize'

class RestaurantList
  attr_reader :rest_list

  # take an allmenus url and scrape through restaurants / menu pages
  def initialize(url)
    @agent = Mechanize.new
    @page = @agent.get(url)
    @noko_page = Nokogiri::HTML(@page.body)
    @rest_list = self.get_names.zip(self.get_addresses, self.get_cuisines, self.get_numbers)
    create_restaurants
  end
  
  private 

  def get_names
    @noko_page.search('.restaurant_name').map { |link| link.inner_text }  
  end

  def get_cuisines
    @noko_page.search('.restaurant_cuisines').map { |link| link.inner_text.strip }  
  end

  def get_addresses
    @noko_page.search('.restaurant_address').map { |link| link.inner_text }  
  end

  def get_numbers
    @noko_page.search('#phone_number').inner_text
  end

  def create_restaurants
    @rest_list.map! do |rest|
      Restaurant.new({ name: rest[0], address: rest[1], cuisine: rest[2], phone: rest[3]})
    end
  end

end