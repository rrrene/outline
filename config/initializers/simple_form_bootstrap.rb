

# Twitter Bootstrap integration
module SimpleForm 
  module Components 
    module ContainedInput 
      def contained_input
        add = error.nil? ? "" : " <span class=\"help-inline\">#{error}</span>"
        '<div class="controls">' + input + add + '</div>'
      end 
    end 
  end 
  module Inputs 
    class Base 
      include SimpleForm::Components::ContainedInput
    end 
  end 
end