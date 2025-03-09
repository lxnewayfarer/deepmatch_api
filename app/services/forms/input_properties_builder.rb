# frozen_string_literal: true

module Forms
  class InputPropertiesBuilder
    INPUT_MAP = {
      string: { name: 'form[form_answers_attributes][][answer]', class: 'form_input_text' },
      phone: {
        name: 'form[form_answers_attributes][][answer]',
        class: 'form_input_text',
        type: 'tel',
        pattern: '\+7[0-9]{3}[0-9]{3}[0-9]{4}',
        placeholder: '+79999999999',
        value: '+7'
      },
      integer: {
        name: 'form[form_answers_attributes][][answer]',
        class: 'form_input_text',
        pattern: '[0-9]*'
      }
    }.freeze

    def self.call(kind)
      INPUT_MAP[kind.to_sym]
    end
  end
end
