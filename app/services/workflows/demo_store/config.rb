# frozen_string_literal: true

module Workflows
  module DemoStore
    class Config
      STATE_ACTIONS = {
        'initial' => {
          '/start' => 'start'
        },
        'started' => {
          'Демо магазина одежды' => 'pretend_store',
          'Контакты' => 'contacts'
        },
        'store_form_filled' => {
          'Пример общей рассылки' => 'common_notification',
          'Пример персонализированной рассылки' => 'personalized_notification',
          'Пример системы лояльности' => 'loyalty_system',
          'Выйти из демо режима' => 'return_to_start'
        },
        'store' => {
          'Выйти из демо режима' => 'return_to_start'
        }
      }.freeze

      class << self
        def main_actions
          STATE_ACTIONS['started']
        end

        def store_actions
          STATE_ACTIONS['store_form_filled']
        end
      end
    end
  end
end
