class IngredientsController < ApplicationController

  def new
    @ingredient = Ingredient.new
    @recipe = Recipe.find_by(:id => params[:recipe_id])
    @ingredients = @recipe.ingredients
  end

  def create
    @recipe = Recipe.find_by(:id => params[:recipe_id])
    item = Item.find_or_create_by(:name => params[:ingredient][:item])
    Ingredient.find_or_create_by(:recipe_id => params[:recipe_id], :item_id => item.id, :quantity => params[:ingredient][:quantity])
    if params[:add] == 'true'
      redirect_to new_recipe_ingredient_path(@recipe) and return
    end
    redirect_to user_recipe_path(current_user, params[:recipe_id])
  end

  def destroy
    ingredient =   Ingredient.find_by(:id => params[:id])
    recipe = ingredient.recipe_id
    ingredient.destroy
    redirect_to new_recipe_ingredient_path(recipe)
  end
end
