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

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
