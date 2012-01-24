module ContentItemsHelper
  def content_item_form_for(symbol, &block)
    content = content_holder.content
    object = instance_variable_get("@#{symbol}") 
    object ||= symbol.to_s.classify.constantize.new(:content => content)
    object_controller = symbol.to_s.underscore.pluralize
    render :partial => "content_items/form", :locals => {:object => object, :content => content, :object_controller => object_controller}
  end
end
