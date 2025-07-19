# frozen_string_literal: true

module TelegramBots
  class SetBotWebhook < ApplicationService
    def call
      webhook_url = "#{ENV['BACKEND_URL']}/api/v1/telegram_webhook"
      ::TelegramAPI.new(ENV['TELEGRAM_BOT_TOKEN']).set_webhook(webhook_url)
    end
  end
end
