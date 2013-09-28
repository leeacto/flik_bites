class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :dish
	
  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
end
