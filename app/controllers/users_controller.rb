class UsersController < ApplicationController

  def new
    if logged_in?
      redirect_to user_path(current_user), :flash => {:message => 'You are already logged in'}
    else
      @user = User.new
    end
  end

  def create
    user = User.create(user_params)
    login(user)
    redirect_to user_path(user), :flash => {:message => 'Signed Up Successfully'}
  end

  def show
  end

  def edit
    if !logged_in?
      redirect_to login_path, :flash => {:message => 'Please login to edit your account'} and return
    elsif current_user == User.find_by(:id => params[:id])
      @user = current_user
    else
      redirect_to root_path, :flash => {:message => 'Please login to edit your account'} and return
    end
  end

  def update
    current_user.update(user_params)
    redirect_to user_path(current_user), :message => 'Update Successful'
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
