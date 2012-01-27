

class SimpleForm::FormBuilder
  def buttons(locals = {})
    options = object.present? ? {:model => object.class.model_name.human} : {}
    create_or_update = object.try(:new_record?) ? :create : :update
    locals[:submit_text] ||= @template.tt("helpers.submit.#{object.class.to_s.underscore}.#{create_or_update}", "helpers.submit.#{create_or_update}", options)
    locals[:cancel_text] ||= @template.tt("helpers.cancel", options)
    locals[:remote] = !!locals[:remote]
    @template.render :partial => "shared/form_buttons", :locals => locals
  end
end