class Restaurant < ActiveRecord::Base
	has_many :dishes
	
	validates_uniqueness_of :name, scope: :address
	validates_presence_of :name
	validates_presence_of :address
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :url

	
end
