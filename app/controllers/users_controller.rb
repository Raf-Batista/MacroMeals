class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def new
    redirect_to user_path(current_user), :flash => {:message => 'You are already logged in'} if logged_in?
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      login(user)
      redirect_to user_path(user), :flash => {:message => 'Signed Up Successfully'} and return
    else
      redirect_to(new_user_path, :flash => {:message => "#{user.errors.full_messages.last}"})
    end 
  end

  def show
    @user= current_user
  end

  def edit
    if current_user == User.find_by(:id => params[:id])
      @user =  current_user
    else
      redirect_to user_path(current_user)
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
