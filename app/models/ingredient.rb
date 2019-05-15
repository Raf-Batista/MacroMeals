class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :item
  validates :quantity, :numericality => { :greater_than => 0 }
end
