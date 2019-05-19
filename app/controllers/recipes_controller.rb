class RecipesController < ApplicationController

  def new
    if !logged_in?
      flash[:message] = 'You can not create a recipe, please sign up or login'
      redirect_to login_path and return
    end
    @user = current_user
    @recipe = @user.recipes.build
  end

  def create
    if !logged_in?
      redirect_to login_path and return
    end
    @user = current_user
    @user.recipes.find_or_create_by(recipe_params)
    redirect_to new_recipe_ingredient_path(@user.recipes.last)
  end

  def show
    @recipe = Recipe.find_by(:id => params[:id])
  end

  def index
    if @user = User.find_by(:id => params[:user_id])
      @recipes = @user.recipes
    else
      @recipes = Recipe.all
    end
  end

  def edit
    @user = current_user
    @recipe = @user.recipes.find_by(:id => params[:id])
  end

  def update
    @user = current_user
    @recipe = @user.recipes.find_by(:id => params[:id])
    @recipe.update(recipe_params)
    redirect_to user_recipe_path(@user, @recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :directions, :prep_time, :cook_time, :protien, :carbs, :fat)
  end

end
