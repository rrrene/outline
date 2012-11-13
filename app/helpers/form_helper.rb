module FormHelper
  def buttons(object, locals = {})
    options = object.present? ? {:model => object.class.model_name.human} : {}
    locals[:submit_text] ||= submit_text(object, options)
    locals[:cancel_text] ||= cancel_text(options)
    locals[:remote] = !!locals[:remote]
    locals[:resource] = object
    render :partial => "shared/form_buttons", :locals => locals
  end

  def cancel_path(resource = nil)
    if resource.present? && !resource.new_record?
      resource_path(resource)
    else
      collection_path if defined?(collection_path)
    end
  end

  def cancel_text(options = {})
    tt("helpers.cancel", options)
  end

  def submit_text(object, options = {})
    create_or_update = object.try(:new_record?) ? :create : :update
    tt("helpers.submit.#{object.class.to_s.underscore}.#{create_or_update}", "helpers.submit.#{create_or_update}", options)
  end
end