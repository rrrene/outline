

class SimpleForm::FormBuilder
  def buttons(submit_text = nil, cancel_text = nil)
    submit_text ||= "Submit"
    cancel_text ||= "Cancel"
    @template.render :partial => "shared/form_buttons", :locals => {:submit_text => submit_text, :cancel_text => cancel_text}
  end
end