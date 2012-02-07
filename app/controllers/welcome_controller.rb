class WelcomeController < ApplicationController
  def index
    if outline_just_set_up?
      redirect_to setup_path
    elsif logged_in?
      redirect_to activity_url
    else
      redirect_to login_url
    end
  end

  private

  def outline_just_set_up?
    User.count == 0
  end
end
