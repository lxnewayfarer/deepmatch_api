# frozen_string_literal: true

module Workflows
  module Demo
    class Config
      class << self
        def actions
          main_actions
        end

        def main_actions
          {
            'Отправить пример общей рассылки' => 'common_notification',
            'Отправить пример персонализированной рассылки' => 'personalized_notification',
            'Контакты' => 'contact'
          }
        end

        def main_keyboard
          {
            keyboard: main_actions.keys.map { |key| [text: key] },
            resize_keyboard: true
          }
        end
      end
    end
  end
end
