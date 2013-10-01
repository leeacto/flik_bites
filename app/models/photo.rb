class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :dish

  has_attached_file :image, 
   styles: {
      medium: {
        geometry: '300x300>',
        processor_options: {
          compression: {
            png: false,
            jpeg: '-copy none -optimize'
          }
        }
      },
      original: {
        geometry: '500x500>',
        processor_options: {
          compression: {
            png: false,
            jpeg: '-copy none -optimize'
          }
        }
      }
    },
    processors: [:thumbnail, :compression]


  validates_attachment_presence :image
end
