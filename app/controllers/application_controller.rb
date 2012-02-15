class ApplicationController < ActionController::Base
  layout :themed_layout
  protect_from_forgery

  helper_method :current_user, :current_domain, :current_project, :current_theme, :logged_in?
  helper_method :recently_viewed_pages, :recently_viewed_projects
  helper_method :themed, :try_translation

  before_filter :set_activity_user

  def themed_layout(layout = :application)
    file = "themes/#{current_theme}/#{layout}"
    if template_exists? file
      file
    else
      "themes/default/#{layout}"
    end
  end

  private

  def current_domain
    current_user.try(:domain)
  end

  def current_project
    @current_project ||= begin
      # use get_collection_ivar instead of resource to avoid lazy loading of resource on index views
      if respond_to?(:get_collection_ivar)
        project = current_project_for(get_collection_ivar)
        project.try(:new_record?) ? nil : project
      end
    end
  end

  def current_project_for(resource)
    if resource.is_a?(Project)
      resource
    elsif resource.respond_to?(:context) && resource.context.try(:resource).is_a?(Project)
      resource.context.resource
    elsif resource.respond_to?(:outer_content)
      current_project_for resource.outer_content.holder
    end
  end

  def current_theme
    params[:theme] || :default
  end
  
  def current_user
    @current_user ||= ::UserSession.find.try(:user)
  end
  alias logged_in? current_user
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def set_activity_user(user = current_user)
    Thread.current[:activity_user] = user
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end

  def recently_viewed(resource_class, limit = 5)
    arel = current_domain.activities.where(:verb => :read, :resource_type => resource_class.to_s).group("resource_type, resource_id")
    arel.limit(limit).map(&:resource)
  end

  def recently_viewed_pages
    recently_viewed Page, 5
  end

  def recently_viewed_projects
    recently_viewed Project, 20
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

  def themed(template_name)
    "layouts/" + themed_layout(template_name)
  end

  def try_translation(snippets = [], options = {})
    options[:default] = ''
    snippets.each do |s| 
      val = I18n.t(s, options).presence
      return val if val
    end
    nil
  end
  alias tt try_translation

end
