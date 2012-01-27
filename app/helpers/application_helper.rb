module ApplicationHelper

  def body_template
    %w(new create edit update show).include?(action_name) ? :body_resource : :body_collection
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
    link_to "Edit", url_options, {:remote => true, :class => "btn edit"}
  end

  def tt(*snippets)
    options = snippets.last.is_a?(Hash) ? snippets.pop : {}
    try_translation(snippets, options) || t(snippets.last)
  end

  def user_text(text)
    simple_format(text)
  end
end