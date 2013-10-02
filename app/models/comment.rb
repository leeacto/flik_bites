class Comment < ActiveRecord::Base
	belongs_to :user	
	belongs_to :dish

	validates_presence_of :content
	validates_presence_of :rating
	validates_uniqueness_of :user_id, scope: :dish_id
end
