

class SimpleForm::FormBuilder
  def buttons(locals = {})
    @template.buttons object, locals
  end
end