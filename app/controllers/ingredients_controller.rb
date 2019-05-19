class IngredientsController < ApplicationController

  def new
    @ingredient = Ingredient.new
    @recipe = Recipe.find_by(:id => params[:recipe_id])
  end

  def create
    item = Item.first_or_create(:name=>params[:ingredient][:item])
    Ingredient.create(:recipe_id => params[:recipe_id], :item_id => item.id, :quantity => params[:ingredient][:quantity])
  end
end
