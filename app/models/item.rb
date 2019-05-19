class Item < ApplicationRecord
  has_many :ingredients
  has_many :recipes, :through => :ingredients

  validates :name, :presence => true, :uniqueness => {case_sensitive: false}
  validates_format_of :name, :with => /\A[a-zA-Z]+\z/
end
