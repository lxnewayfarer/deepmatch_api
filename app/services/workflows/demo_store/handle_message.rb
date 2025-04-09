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
        return process_workflow if workflow_command?

        return ::Workflows::DemoStore::Process::Start.call(user) if start_command?

        return if ::Workflows::DemoStore::Process::ForceAction.call(user)

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
