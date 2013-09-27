class Dish < ActiveRecord::Base
  belongs_to :restaurant
  has_many :photos

  validates_presence_of :name, :category
  validates_uniqueness_of :restaurant_id, scope: :name
  
  scope :starters, -> { where(category: 'starter') }
	scope :entrees, -> { where(category: 'entree') }
	scope :desserts, -> { where(category: 'dessert') }
end
