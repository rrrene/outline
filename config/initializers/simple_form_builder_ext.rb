

class SimpleForm::FormBuilder
  def buttons(locals = {})
    locals[:submit_text] ||= I18n.t("shared.submit")
    locals[:cancel_text] ||= I18n.t("shared.cancel")
    locals[:remote] = !!locals[:remote]
    @template.render :partial => "shared/form_buttons", :locals => locals
  end
end