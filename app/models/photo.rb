class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :dish
	
  has_attached_file :image, styles: {
    medium: '300x300'
  }

  validates_attachment_presence :image
end
