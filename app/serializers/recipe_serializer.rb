class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :protien, :carbs, :fat, :cook_time, :macros, :directions, :prep_time, :ingredients
  belongs_to :user, serializer: UserRecipeSerializer
  has_many :ingredients, serializer: IngredientSerializer
end
