class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  validates :username, :presence => true, :uniqueness => {case_sensitive: false}
  has_many :recipes
  has_many :recipe_ratings
end
