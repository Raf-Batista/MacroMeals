class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    redirect_to root_path, :flash => {:message => 'Signed Up Successfully'}
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
