# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class ReturnToStart < WorkflowService
        attr_reader :user

        def call(user)
          @user ||= user

          ::Workflows::DemoStore::ChangeState.call(user:, state: 'started')
          TelegramBots::HideWebAppMenuButton.call(bot, user)
          TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'start', reply_markup: reply_markup('main'))
        end
      end
    end
  end
end
