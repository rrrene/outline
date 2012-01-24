

class SimpleForm::FormBuilder
  def buttons(locals = {})
    locals[:submit_text] ||= "Submit"
    locals[:cancel_text] ||= "Cancel"
    locals[:remote] = !!locals[:remote]
    @template.render :partial => "shared/form_buttons", :locals => locals
  end
end