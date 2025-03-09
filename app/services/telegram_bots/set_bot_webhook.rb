# frozen_string_literal: true

module TelegramBots
  class SetBotWebhook < ApplicationService
    def call(bot)
      ::TelegramAPI.new(bot.token).set_webhook(bot.webhook_url)
    end
  end
end
