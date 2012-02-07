module ApplicationHelper

  def body_template
    resource_action = %w(new create edit update show).include?(action_name)
    if resource_action || controller_name == "activities"
      :body_resource
    else
      :body_collection
    end
  end

  def filter_form(*args, &block)
    url_options = params.merge(:page => 1)
    html_options = {:class => "form-stacked", :remote => false, :method => :get}
    form_tag(url_options, html_options, &block)
  end

  def icon(name, second_class = nil)
    classes = "#{name} #{second_class}".strip
    %Q(<i class="icon-#{classes}"></i> ).html_safe
  end

  def link_to_resource(resource)
    text = resource.respond_to?(:title) ? resource.title : resource.class.to_s
    link_to inline_user_text(text), resource
  end

  def nav_to(text, path)
    active = if path.is_a?(Symbol)
      controller_name == path.to_s
    else
      current_path?(path)
    end
    path = {:controller => path, :action => :index} if path.is_a?(Symbol)
    content_tag :li, link_to(text, path), :class => active ? :active : nil
  end

  def edit_link(record)
    record_controller = record.class.to_s.underscore.pluralize
    url_options = {:controller => record_controller, :action => :edit, :id => record}
    link_to icon(:edit) + " " + tt("helpers.edit.#{record.class.to_s.underscore}", "helpers.edit.default"), url_options, {:remote => true, :class => "btn edit"}
  end

  def resource_is_context_resource
    if resource.respond_to?(:context) 
      resource == resource.try(:context).try(:resource)
    else
      false
    end
   end

  def spacer
    "<div class=\"spacer\"><hr/></div>".html_safe
  end

  include MarkdownHelper
  
  def format_multi_line_user_input(text)
    text = auto_link gfm(text) # uses GitHub flavored markdown from MarkdownHelper
    RDiscount::new(text).to_html
  end
  
  def user_text(text)
    text = inline_user_text(text)
    find_and_preserve format_multi_line_user_input(text).html_safe
  end

  def inline_user_text(text)
    sanitize(text.to_s)
  end
end