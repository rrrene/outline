module ContentItemsHelper
  def content_item_form_for(symbol, &block)
    content = content_holder.content
    object = instance_variable_get("@#{symbol}") 
    object ||= symbol.to_s.classify.constantize.new(:content => content)
    object_controller = symbol.to_s.underscore.pluralize
    render :partial => "content_items/form", :locals => {:object => object, :content => content, :object_controller => object_controller}
  end

  def update_html(record, render_params)
    content = escape_javascript(render(render_params))
    render :partial => "shared/js/update_html", :locals => {:resource => record, :content => content}
  end

  def replace_dom(record, render_params)
    content = escape_javascript(render(render_params))
    render :partial => "shared/js/replace_dom", :locals => {:resource => record, :content => content}
  end

  def remove_dom(record)
    render :partial => "shared/js/remove_dom", :locals => {:resource => record}
  end
end
