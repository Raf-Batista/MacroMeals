class RecipesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.build
  end

  def create
    user = User.find(params[:user_id])
    if user.recipes.build(recipe_params).save
      Ingredient.create_ingredients(user.recipes.last.id, params[:ingredient])
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :directions, :prep_time, :cook_time, :protien, :carbs, :fat)
  end
end
