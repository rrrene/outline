module ContentItemsHelper

  def content_item_detail_view(&block)
    object = resource
    rendered = block_given? ? capture(&block) : render("content_items/show", :content_item => resource.content_item)
    render :partial => "content_items/detail_view", :locals => {:resource => object, :rendered => rendered}
  end

  def content_item_form_for(model, options = {}, &block)
    symbol = model.to_s.underscore.to_sym
    object = instance_variable_get("@#{symbol}") 
    content = options[:content] || content_holder.try(:inner_content)
    object ||= symbol.to_s.classify.constantize.new(:content_id => content.try(:id))
    object_controller = symbol.to_s.underscore.pluralize
    remote = true
    render :partial => "content_items/form", :locals => {:resource => object, :content => content, :object_controller => object_controller, :resource_key => symbol, :remote => remote}
  end

  def insert_html(method, dom_element_id, render_params)
    content = escape_javascript(render(render_params))
    render :partial => "shared/js/insert_html", :locals => {:method => method, :dom_element_id => dom_element_id, :content => content}
  end
  
  def update_html(record_or_string, render_params)
    content = escape_javascript(render(render_params))
    dom_element_id = record_or_string.is_a?(String) ? record_or_string : dom_id(record_or_string)
    render :partial => "shared/js/update_html", :locals => {:dom_element_id => dom_element_id, :resource => record_or_string, :content => content}
  end

  def replace_dom(record_or_string, render_params)
    content = escape_javascript(render(render_params))
    dom_element_id = record_or_string.is_a?(String) ? record_or_string : dom_id(record_or_string)
    render :partial => "shared/js/replace_dom", :locals => {:dom_element_id => dom_element_id, :resource => record_or_string, :content => content}
  end

  def remove_dom(record_or_string)
    render :partial => "shared/js/remove_dom", :locals => {:resource => record_or_string}
  end

  def partial_for(model, action, fallback_dir = "content_items")
    partials = ["#{model.to_s.underscore.pluralize}/#{action}", "#{fallback_dir}/#{action}"]
    partials.detect { |p| controller.template_exists?(p, [], true) }
  end

  def render_partial_for(model, action, options = {})
    options[:locals] ||= {}
    options[:locals][:model] = model
    partials = ["#{model.to_s.underscore.pluralize}/#{action}", "content_items/#{action}"]
    partial = partials.detect { |p| controller.template_exists?(p, [], true) }
    render options.merge(:partial => partial)
  end
end
