class SessionsController < ApplicationController
  def new
    logged_in? ? redirect_to(user_path(current_user)) : render(:new)
  end

  def create
    if auth
      user = User.from_omniauth(auth)
      redirect_to user_path(user)
    else
      user = User.find_by(:username => params[:username])
      user ? verify(user) : redirect_to(login_path, :flash => {:notice => 'The email or password you entered was incorrect'})
    end
  end

  def destroy
    logout
    redirect_to login_path, :flash => {:message => 'Logout Successful'}
  end

  private

  def auth
    request.env["omniauth.auth"]
  end

  def verify(user)
    if user.authenticate(params[:password])
      redirect_to user_path(user), :flash => {:message => 'Log in Successful'}
    else
      redirect_to login_path, :flash => {:message => 'The email or password you entered was incorrect'}
    end
  end
end
