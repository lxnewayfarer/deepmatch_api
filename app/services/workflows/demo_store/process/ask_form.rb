# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class AskForm < WorkflowService
        attr_reader :user

        def call(user)
          @user ||= user

          TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'ask_for_fill_the_form', reply_markup: ReplyMarkup.new(bot).blank)
        end
      end
    end
  end
end
