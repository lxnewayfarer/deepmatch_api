# frozen_string_literal: true

module Workflows
  module DemoStore
    class Config
      class << self
        def actions
          {
            '/start' => 'start'
          }.merge(main_actions)
        end

        def main_actions
          {
            'Пример общей рассылки' => 'common_notification',
            'Пример персонализированной рассылки' => 'personalized_notification',
            'Пример системы лояльности' => 'loyalty_system',
            'Контакты' => 'contacts'
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
