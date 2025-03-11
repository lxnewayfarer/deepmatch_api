# frozen_string_literal: true

module TelegramBots
  class HandleMessage < ApplicationService
    include TelegramParamsParser
    prepend WithConfig

    attr_reader :params

    def call(params)
      @params ||= params

      log_message

      return ::TelegramBots::Process::Start.call(user) if start_command?
      return ::TelegramBots::Process::AskForm.call(user) if user.started?

      return process_workflow if workflow_command?

      ::TelegramBots::AIResponse.call(user, text)
    end

    private

    def log_message
      message = Message.create!(user:, text:)
      ::TelegramBots::SetUserMessageResponse.call(user:, message:)
    end
  end
end
