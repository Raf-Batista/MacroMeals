class Recipe < ApplicationRecord
  validates :name, :presence => {:message => 'Your Recipe needs to have a name'}
  validates :directions, :presence => {:message => 'Your Recipe needs to have directions'}
  belongs_to :user
  has_many :ingredients
  has_many :items, :through => :ingredients
  has_many :recipe_ratings

  def macros
    "protien: #{self.protien}g carbs: #{self.carbs}g fat: #{self.fat}g"
  end
end
