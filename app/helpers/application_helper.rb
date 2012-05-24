module ApplicationHelper

  def body_template
    return @body_template if @body_template
    resource_action = %w(new create edit update show).include?(action_name)
    if resource_action || controller_name == "activities"
      :body_resource
    else
      :body_collection
    end
  end

  def filter_form(filtered_param = nil, *args, &block)
    filter_params = params.merge(:page => nil, :controller => nil, :action => nil, :utf8 => nil, filtered_param => nil)
    render :layout => "shared/index/filter_form", :locals => {:filter_params => filter_params}, &block
  end

  def html_title
    domain_title = current_domain.presence.try(:title).to_s
    generic_title = if @page_header.present?
      inline_user_text @page_header
    elsif defined?(resource) && !resource_is_context_resource? && resource.respond_to?(:title) && !resource.new_record?
      inline_user_text resource.title
    else
      t("#{controller_name}.#{action_name}.page_header")
    end
    if generic_title.present?
      "#{generic_title} - #{domain_title}"
    else
      domain_title
    end
  end

  def icon(name, second_class = nil)
    classes = "#{name} #{second_class}".strip
    %Q(<i class="icon-#{classes}"></i> ).html_safe
  end

  def link_to_resource(resource, text = nil)
    text ||= resource.respond_to?(:title) ? resource.title : resource.class.to_s
    link_to inline_user_text(text), resource, :rel => resource.class.to_s.underscore.dasherize
  end

  def nav_to(text, path, controller = nil)
    active = if path.is_a?(Symbol) || controller
      [path.to_s, controller.to_s].include? controller_name
    else
      current_page?(path)
    end
    path = {:controller => path, :action => :index} if path.is_a?(Symbol)
    content_tag :li, link_to(text, path), :class => active ? :active : nil
  end

  def edit_link(record)
    record_controller = record.class.to_s.underscore.pluralize
    url_options = {:controller => record_controller, :action => :edit, :id => record}
    link_to icon(:edit) + " " + tt("helpers.edit.#{record.class.to_s.underscore}", "helpers.edit.default"), url_options, {:remote => true, :class => "btn edit"}
  end

  def resource_is_context_resource?
    if resource.respond_to?(:context) 
      resource == resource.try(:context).try(:resource)
    else
      false
    end
   end

  def spacer
    "<div class=\"spacer\"><hr/></div>".html_safe
  end

  def update_sidebar_if_requested
    if params[:update_sidebar].present?
      render :partial => "shared/js/update_sidebar"
    end
  end
end