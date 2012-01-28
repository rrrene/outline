module ContentItemsHelper

  def content_item_detail_view(&block)
    object = resource
    rendered = block_given? ? capture(&block) : render("show")
    render :partial => "content_items/detail_view", :locals => {:resource => object, :rendered => rendered}
  end

  def content_item_form_for(model, &block)
    symbol = model.to_s.underscore.to_sym
    content = content_holder.content
    object = instance_variable_get("@#{symbol}") 
    object ||= symbol.to_s.classify.constantize.new(:content => content)
    object_controller = symbol.to_s.underscore.pluralize
    remote = request.xhr?
    render :partial => "content_items/form", :locals => {:resource => object, :content => content, :object_controller => object_controller, :remote => remote}
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
