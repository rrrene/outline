

class SimpleForm::FormBuilder
  def buttons(locals = {})
    resource = locals[:resource]
    options = {:model => resource.class.model_name.human}
    resource_key = resource.class.to_s.underscore
    create_or_update = resource.try(:new_record?) ? :create : :update
    locals[:submit_text] ||= @template.tt("helpers.submit.#{resource_key}.#{create_or_update}", "helpers.submit.#{create_or_update}", options)
    locals[:cancel_text] ||= @template.tt("helpers.cancel", options)
    locals[:remote] = !!locals[:remote]
    @template.render :partial => "shared/form_buttons", :locals => locals
  end
end