module ApplicationHelper
  def nav_to(text, path)
    active = if path.is_a?(Symbol)
      controller_name == path.to_s
    else
      current_path?(path)
    end
    path = {:controller => path, :action => :index} if path.is_a?(Symbol)
    content_tag :li, link_to(text, path), :class => active ? :active : nil
  end
end