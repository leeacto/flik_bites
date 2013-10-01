class Comment < ActiveRecord::Base
	belongs_to :user	
	belongs_to :dish

	validates_presence_of :content
end
