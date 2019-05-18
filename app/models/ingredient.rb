class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :item
  validates :quantity, :numericality => { :greater_than => 0 }

  def self.create_ingredients(recipe_id, ingredients_array)
    ingredients_array.each do |ingredient_hash|
      item = Item.where('lower(name) = ?', name.downcase).first_or_create(:name => ingredient_hash[:name])
      Ingredient.create(:recipe_id => recipe_id, :item_id => item.id, :quantity => ingredient_hash[:quantity])
    end
  end
end
