class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :protien, :carbs, :fat, :cook_time, :macros
  belongs_to :user, serializer: UserRecipeSerializer
end
