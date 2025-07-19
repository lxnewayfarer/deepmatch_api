# frozen_string_literal: true

module TelegramBots
  class HandleMessage < ApplicationService
    include TelegramParamsParser

    attr_reader :params

    def call(params)
      @params = params
      return ::Auth::Handle.call(user, start_context) if start_command_with_context?

      ::TelegramBots::SendMessage.call(user, 'Пока что этот бот умеет только авторизовывать пользователей')
    end
  end
end
