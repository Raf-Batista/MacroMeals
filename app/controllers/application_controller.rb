class ApplicationController < ActionController::Base
  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.clear
  end
end
