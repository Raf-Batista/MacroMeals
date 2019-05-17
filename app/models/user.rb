class User < ApplicationRecord
  require 'securerandom'

  has_secure_password
  validates :username, :presence => true, :uniqueness => {case_sensitive: false}
  has_many :recipes
  has_many :recipe_ratings

  def self.from_omniauth(auth)
    where(:provider => auth[:provider], :uid => auth[:uid]).first_or_create do |user|
      user.username = "#{auth[:info][:name].gsub(' ', '_')}#{rand(6 ** 6)}"
      user.password = SecureRandom.base64(15)
    end
  end
end
