class Dish < ActiveRecord::Base
  belongs_to :restaurant
  has_many :photos

  validates_presence_of :name, :category
  validates_uniqueness_of :restaurant_id, scope: :name
  
  def self.search(term)
    if term
      where('lower(name) LIKE ?', "%#{term.downcase.strip}%")
    end
  end
end
