class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_domain, :logged_in?

  private

    def current_domain
      current_user.try(:domain)
    end

    def current_user
      @current_user ||= ::UserSession.find.try(:user)
    end
    alias logged_in? current_user


    # Use this in a controller to restrict access.
    # 
    #   class UsersController < ApplicationController
    #     login_required :only => [:edit, :update, :show]
    #   end
    #
    def self.login_required(opts = {}) # :doc:
      before_filter :require_user, opts
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        respond_to do |format|
          format.html { redirect_to login_url }
        end
        return false
      end
    end
    
end
