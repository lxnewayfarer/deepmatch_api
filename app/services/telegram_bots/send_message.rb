# frozen_string_literal: true

module TelegramBots
  class SendMessage < ApplicationService
    def call(bot:, user:, text:, reply_markup:)
      messages = TelegramMessageFactory.call(user.telegram_id, text, reply_markup)

      SendMessageJob.perform_async(bot.token, messages.to_json)
    end
  end
end
