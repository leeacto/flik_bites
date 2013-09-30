class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :dish
	
  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_presence :image

  # cancel post-processing now, and set flag...
  before_image_post_process do |photo|
    if !photo.processing && photo.source_changed?
      photo.processing = true
      false # halts processing
    end
  end
 
  # ...and perform after save in background
  after_save do |photo| 
    if !photo.processing && photo.source_changed?
      Delayed::Job.enqueue PhotoJob.new(photo.id)
    end
  end
 
  # generate styles (downloads original first)
  def regenerate_styles!
    self.image.reprocess! 
    self.processing = false   
    self.save(:validations => false)
  end
 
  # detect if our source file has changed
  def source_changed?
    self.image_file_size_changed? || 
    self.image_file_name_changed? ||
    self.image_content_type_changed? || 
    self.image_updated_at_changed?
  end
end

class PhotoJob < Struct.new(:photo_id)
  def perform
    Photo.find(self.photo_id).regenerate_styles!
  end
end