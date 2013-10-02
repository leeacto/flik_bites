class Restaurant < ActiveRecord::Base
  has_many :dishes
  has_many :photos, through: :dishes
  validates_uniqueness_of :name, scope: :address
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :url

  # REVIEW(RCB): Is it even possible to get to the else in this? I don't see a test for it.
  def self.search(term)
    if term
      where('lower(name) LIKE ?', "%#{term.downcase.strip}%")
    else
      all
    end
  end
end
