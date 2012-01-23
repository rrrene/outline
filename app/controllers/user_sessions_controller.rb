class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new(params[:user_session])
  end
  
  # Authenticates a User by creating and saving a UserSession.
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_back_or_default root_url
    else
      @failed = true
      render :action => :new
    end
  end
  
  # this is kind of a bugfix:
  # after an unsuccessful POST to index (#create),
  # a reload caused a 'no such action' error 
  # (because it's a GET request now)
  def index
    render :action => :new
  end
  
  # Logs a user out.
  def destroy
    UserSession.find.try(:destroy)
    redirect_back_or_default login_url
  end
end
