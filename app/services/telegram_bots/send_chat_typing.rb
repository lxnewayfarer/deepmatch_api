# frozen_string_literal: true

module TelegramBots
  class SendChatTyping < ApplicationService
    def call(bot, user)
      ::TelegramAPI.new(bot.token).send_chat_action(chat_id: user.telegram_id)
    end
  end
end
