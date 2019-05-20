class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :item
  validates :quantity, :presence => true
end
