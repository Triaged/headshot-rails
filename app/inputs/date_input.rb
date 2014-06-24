module SimpleForm
  module Inputs
    class DateInput < SimpleForm::Inputs::DateInput 
      def input_html_options
        {class: 'form-control datepicker'}
      end
    end
  end
end