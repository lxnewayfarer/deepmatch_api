# frozen_string_literal: true

module Workflows
  module DemoStore
    class Keyboards
      class << self
        def main
          {
            keyboard: Config.main_actions.keys.map { |key| [text: key] },
            resize_keyboard: true
          }
        end

        def store
          {
            keyboard: Config.store_actions.keys.map { |key| [text: key] },
            resize_keyboard: true
          }
        end
      end
    end
  end
end
