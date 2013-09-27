class DownVotePhoto < ActiveRecord::Base
	belongs_to :user
	belongs_to :photo
	has_one :restaurant, through: :photo
	
end
