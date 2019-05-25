class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def new
    logged_in? ? redirect_to(user_path(current_user), :flash => {:message => 'You are already logged in'}) : render(:new)
  end

  def create
    if auth
      user = User.from_omniauth(auth)
      login(user)
      redirect_to user_path(user), :flash => {:message => 'Log in Successful'}
    else
      user = User.find_by(:username => params[:username])
      user ? verify(user) : redirect_to(login_path, :flash => {:notice => 'Account not found. Sign up or check to make sure you entered the information correctly'})
    end
  end

  def destroy
    logout
    redirect_to login_path, :flash => {:message => 'Logout Successful'}
  end

  private

  def verify(user)
    if user.authenticate(params[:password])
      login(user)
      redirect_to user_path(user), :flash => {:message => 'Log in Successful'}
    else
      redirect_to login_path, :flash => {:message => 'The password you entered was incorrect'}
    end
  end
end
