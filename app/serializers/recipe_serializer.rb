class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :protien, :carbs, :fat, :cook_time
  belongs_to :user, serializer: UserRecipeSerializer
end
