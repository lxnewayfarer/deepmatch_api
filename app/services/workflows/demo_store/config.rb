# frozen_string_literal: true

module Workflows
  module DemoStore
    class Config
      class << self
        def actions
          {
            '/start' => 'start'
          }
            .merge(main_actions)
            .merge(store_actions)
        end

        def main_actions
          {
            'Демо магазина одежды' => 'pretend_store',
            'Контакты' => 'contacts'
          }
        end

        def store_actions
          {
            'Пример общей рассылки' => 'common_notification',
            'Пример персонализированной рассылки' => 'personalized_notification',
            'Пример системы лояльности' => 'loyalty_system',
            'Контакты' => 'contacts'
          }
        end
      end
    end
  end
end
