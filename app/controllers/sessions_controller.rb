class SessionsController < ApplicationController
  def new
  end

  def create
    if auth
      User.from_omniauth(auth)
      redirect_to root_path
    else
      user = User.find_by(:username => params[:username])
      redirect_to user_path(user), :flash => {:message => 'Log in Successful'}
    end
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
