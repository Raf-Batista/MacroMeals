class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.clear
  end

  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def auth
    request.env["omniauth.auth"]
  end

  def require_login
    redirect_to login_path, :flash => {:message => 'Please login'}  if !logged_in?
  end

end
