class Dish < ActiveRecord::Base
  belongs_to :restaurant
  has_many :photos

  validates_presence_of :name, :category
  validates_uniqueness_of :restaurant_id, scope: :name
  
  scope :starters, -> { where(category: 'Starter') }
  scope :entrees, -> { where(category: 'Entree') }
  scope :desserts, -> { where(category: 'Dessert') }
end
