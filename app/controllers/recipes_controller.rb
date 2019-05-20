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
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to new_recipe_ingredient_path(@recipe)
    else
      flash[:warning] = @recipe.errors.full_messages.join(', ')
      render :new
    end
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
    if !current_user.recipes.find_by(:id => params[:id])
      flash[:message] = "You can not edit another user's recipe"
      redirect_to root_path and return
    end
    @user = current_user
    @recipe = @user.recipes.find_by(:id => params[:id])
  end

  def update
    @recipe = current_user.recipes.find_by(:id => params[:id])
    if @recipe.update(recipe_params)
      redirect_to user_recipe_path(current_user, @recipe)
    else
      flash[:warning] = @recipe.errors.full_messages.join(', ')
      render :edit
    end
  end

  def ten_minute_meals
    @recipes = Recipe.ten_minute_meals
    render :index
  end

  def max_protien
    @recipes = Recipe.max_protien
    render :index
  end

  def max_carbs
    @recipes = Recipe.max_carbs
    render :index
  end

  def max_fat
    @recipes = Recipe.max_fat
    render :index
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :directions, :prep_time, :cook_time, :protien, :carbs, :fat)
  end

end
