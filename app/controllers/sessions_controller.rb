class SessionsController < ApplicationController
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
      user ? verify(user) : redirect_to(login_path, :flash => {:notice => 'The email or password you entered was incorrect'})
    end
  end

  def destroy
    if logged_in?
      logout
      redirect_to login_path, :flash => {:message => 'Logout Successful'}
    else
      redirect_to login_path, :flash => {:message => 'Can not log out, you are not logged in'}
    end
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
