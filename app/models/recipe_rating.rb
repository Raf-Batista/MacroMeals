class RecipeRating < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :rating, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 5}, :allow_blank => true
end
