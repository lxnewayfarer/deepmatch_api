# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class CommonNotification < ApplicationService
        def call(user)
          ::TelegramBots::SendMessageTemplate.call(
            bot: user.bot,
            user: user,
            slug: 'common_notification',
            reply_markup: ReplyMarkup.new(user.bot).main,
            params: {
              merch_title: 'Dr. Martens'
            }
          )
        end
      end
    end
  end
end
