# frozen_string_literal: true

module TelegramBots
  class HandleMessage < ApplicationService
    include TelegramParamsParser

    attr_reader :params

    def call(params)
      @params ||= params

      log_message

      TelegramBots::SendChatTyping.call(bot, user)

      process_state_command
    end

    private

    def allowed_actions
      StatesConfig::STATE_ACTIONS[user.state]
    end

    def action
      allowed_actions[text] || 'bad_request'
    end

    def state_command?
      allowed_actions&.keys&.include?(text)
    end

    def process_state_command
      "StateCommands::#{action.camelize}".constantize.call(user)
    end

    def log_message
      message = Message.create!(user:, text:)
      ::TelegramBots::SetUserMessageResponse.call(user:, message:)
    end
  end
end
