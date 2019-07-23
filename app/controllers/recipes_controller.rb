class RecipesController < ApplicationController
skip_before_action :verify_authenticity_token
  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    @recipe.save
    @recipe.create_ingredients(ingredient_params[:ingredient])
    redirect_to new_recipe_ingredient_path(@recipe) if !request.xhr?
    # else
    #   flash[:warning] = @recipe.errors.full_messages.join(', ')
    #   render :new
    # end
  end

  def show
    @recipe = Recipe.find_by(:id => params[:id])
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @recipe}
    end
  end

  def index
    @recipes = Recipe.all
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @recipes}
    end
  end

  def edit
    if !current_user.recipes.find_by(:id => params[:id])
      redirect_to root_path, :flash => {:message => "You can not edit another user's recipe"} and return
    end
    @recipe = current_user.recipes.find_by(:id => params[:id])
  end

  def update
    @recipe = current_user.recipes.find_by(:id => params[:id])
    if @recipe.update(recipe_params)
      redirect_to user_recipe_path(current_user, @recipe), :flash => {:message => 'Update Successful'}
    else
      flash[:warning] = @recipe.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if recipe = current_user.recipes.find_by(:id => params[:id])
      recipe.destroy
      redirect_to root_path, :flash => {:message => 'Recipe deleted'} and return
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

  def ingredient_params
    params.require(:recipe).permit(:ingredient => [:name, :quantity])
  end

end


















#
#
#
#
#
#
