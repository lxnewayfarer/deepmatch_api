# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class CommonNotification < WorkflowService
        attr_reader :user

        def call(user)
          @user = user

          ::TelegramBots::SendMessageTemplate.call(
            bot: user.bot,
            user: user,
            slug: 'common_notification',
            reply_markup: reply_markup('store'),
            params: {
              merch_title: 'Dr. Martens'
            }
          )
        end
      end
    end
  end
end
