class Restaurant < ActiveRecord::Base
	has_many :dishes
	validates_uniqueness_of :name, scope: :address
end
