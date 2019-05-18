class RecipesController < ApplicationController

  def new
    @user = current_user
    @recipe = @user.recipes.build
  end

  def create
    @user = current_user
    if @user.recipes.find_or_create_by(recipe_params)#.build(recipe_params).save
      Ingredient.create_ingredients(@user.recipes.last.id, params[:ingredient])
    end
    redirect_to user_recipe_path(@user, @user.recipes.last)
  end

  def show
    if @user = current_user
      @recipe = @user.recipes.find_by(:id => params[:id])
    else
      @recipe = Recipe.find_by(:id => params[:id])
    end
  end

  def index

  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :directions, :prep_time, :cook_time, :protien, :carbs, :fat)
  end

end
