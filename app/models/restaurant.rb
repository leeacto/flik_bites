class Restaurant < ActiveRecord::Base
  has_many :dishes
  has_many :photos, through: :dishes
  validates_uniqueness_of :name, scope: :address
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :url

  def self.search(term)
    if term
      where('lower(name)    LIKE ? OR 
             lower(cuisine) LIKE ? OR
             zip            LIKE ?', 
             "%#{term.downcase.strip}%",
             "%#{term.downcase.strip}%",
             "%#{term.downcase.strip}%")
    else
      all
    end
  end
end
