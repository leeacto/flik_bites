class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :dish
	
  has_attached_file :image, {
        :styles => {
          :medium => ["654x500>", :jpg],
          :thumb =>["200x200#", :jpg]
        },
        :convert_options => {
          :medium => "-quality 80 -interlace Plane",
          :thumb => "-quality 80 -interlace Plane"
          }
        },
         :processors => [:thumbnail, :compression]
end
