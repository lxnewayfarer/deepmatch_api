# frozen_string_literal: true

module Workflows
  module Demo
    module Process
      class CommonNotification < ApplicationService
        def call(user)
          ::TelegramBots::SendMessageTemplate.call(
            bot: user.bot,
            user: user,
            slug: 'common_notification',
            reply_markup: ReplyMarkup.new(user.bot).blank,
            params: {
              merch_title: 'Dr. Martens'
            }
          )
        end
      end
    end
  end
end
