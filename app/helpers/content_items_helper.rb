module ContentItemsHelper

  def content_item_detail_view(&block)
    object = resource
    rendered = block_given? ? capture(&block) : render("show")
    render :partial => "content_items/detail_view", :locals => {:resource => object, :rendered => rendered}
  end

  def content_item_form_for(model, options = {}, &block)
    symbol = model.to_s.underscore.to_sym
    object = instance_variable_get("@#{symbol}") 
    content = options[:content] || content_holder.inner_content
    object ||= symbol.to_s.classify.constantize.new(:content_id => content.id)
    object_controller = symbol.to_s.underscore.pluralize
    remote = request.xhr?
    render :partial => "content_items/form", :locals => {:resource => object, :content => content, :object_controller => object_controller, :remote => remote}
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

  def partial_for(model, action)
    partials = ["#{model.to_s.underscore.pluralize}/new", "content_items/new"]
    partials.detect { |p| controller.template_exists?(p, [], true) }
  end

  def render_partial_for(model, action, options = {})
    options[:locals] ||= {}
    options[:locals][:model] = model
    partials = ["#{model.to_s.underscore.pluralize}/new", "content_items/new"]
    partial = partials.detect { |p| controller.template_exists?(p, [], true) }
    render options.merge(:partial => partial)
  end
end
