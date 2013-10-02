class Dish < ActiveRecord::Base
  belongs_to :restaurant
  has_many :photos
  has_many :comments

  validates_presence_of :name, :category
  validates_uniqueness_of :restaurant_id, scope: :name

  def self.search(term)
    if term
      where('lower(name) LIKE ? OR
             lower(category) LIKE ?', 
             "%#{term.downcase.strip}%",
             "%#{term.downcase.strip}%",)
    else
      all
    end
  end
end
