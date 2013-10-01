class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :dish
	
  has_attached_file :image, styles: {
                              medium: { 
                                geometry: '300x300',
                                quality: 60 }
  }

  validates_attachment_presence :image
end
