module BulkCollectionHelper
  
  # Renders a list of records (with its labels and a checkbox next to them) 
  # and provides options as soon as records are selected.
  def bulk_collection(collection_key = controller_name, select_hint = "", locals = {}, &block)
    locals = {
      :collection => instance_variable_get("@#{collection_key}"),
      :collection_key => collection_key.intern,
      :form_params => {:controller => collection_key, :action => 'execute'},
      :resource_key => collection_key.to_s.singularize.intern,
      :resource_partial => "bulk_collection_entry",
      :return_to => url_for(params),
      :select_hint => select_hint, 
      :select_options => capture(&block), 
    }.merge(locals)
    render(:partial => "shared/bulk_collection", :locals => locals)
  end

  def bulk_action(action)
    render :partial => "shared/bulk_#{action}"
  end
  
  def bulk_actions(*actions)
    actions.map { |action| bulk_link(action) }.join("\n").html_safe
  end

end