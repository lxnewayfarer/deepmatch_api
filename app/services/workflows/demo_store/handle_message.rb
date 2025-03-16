# frozen_string_literal: true

module Workflows
  module DemoStore
    class HandleMessage < ApplicationService
      include WithConfig
      include TelegramParamsParser

      attr_reader :params

      def call(params)
        @params ||= params

        log_message

        return ::Workflows::DemoStore::Process::Start.call(user) if start_command?
        return ::Workflows::DemoStore::Process::AskForm.call(user) if user.started?

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
end
