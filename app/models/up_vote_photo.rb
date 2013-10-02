# REVIEW(RCB): what does this do? I don't see a reference to it anywhere
class UpVotePhoto < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  has_one :restaurant, through: :photo

end
