class IngredientsController < ApplicationController

  def new
    @ingredient = Ingredient.new
    @recipe = Recipe.find_by(:id => params[:recipe_id])
    @ingredients = @recipe.ingredients
  end

  def create
    item = Item.first_or_create(:name => params[:ingredient][:item])
    Ingredient.create(:recipe_id => params[:recipe_id], :item_id => item.id, :quantity => params[:ingredient][:quantity])
    if params[:add] == 'true'
      redirect_to new_recipe_ingredient_path(params[:recipe_id]) and return
    end
    redirect_to user_recipe_path(current_user, params[:recipe_id])
  end

end
