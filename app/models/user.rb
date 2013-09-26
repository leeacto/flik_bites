require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :email, presence: true, uniqueness: true
	validates :password_digest, presence: true
	validates :zipcode, presence: true

  has_many :photos
  has_many :up_votes
  has_many :down_votes

  def activate_account!
    update_attribute :is_active, true
  end

  def deactivate_account!
    update_attribute :is_active, false
  end
end