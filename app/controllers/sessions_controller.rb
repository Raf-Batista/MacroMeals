class SessionsController < ApplicationController
  def create
    User.from_omniauth(auth)
    redirect_to root_path
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
