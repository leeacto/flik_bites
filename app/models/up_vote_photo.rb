class UpVotePhoto < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  has_one :restaurant, through: :photo
  # validates_uniqueness_of user_id:, photo_id:
end
