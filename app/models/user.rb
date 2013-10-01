require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  
  validates :username, presence: true,uniqueness: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :email, presence: true,uniqueness: true


  has_many :photos
  has_many :up_votes
  has_many :down_votes
  has_many :comments

  def activate_account!
    update_attribute :is_active, true
  end

  def deactivate_account!
    update_attribute :is_active, false
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      email = auth.info.email || auth.info.nickname+"@gmail.com"
      user.username = auth.info.name
      user.email = email
      user.provider = auth.provider
      user.uid = auth.uid.to_i
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      if user.oauth_expires_at!=nil
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
      user.save!
    end
  end

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end