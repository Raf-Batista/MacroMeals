class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
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
end
