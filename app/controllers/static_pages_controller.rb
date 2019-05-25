class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def home
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def about
  end
end
