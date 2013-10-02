class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :dish
  has_many :up_vote_photos
  has_many :down_vote_photos

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

  def total_votes 
    up_vote_photos.count + down_vote_photos.count
  end
end
