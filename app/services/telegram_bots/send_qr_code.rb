# frozen_string_literal: true

module TelegramBots
  class SendQrCode < ApplicationService
    def call(bot, user, data)
      ::SendQrCodeJob.perform_async(bot.token, user.telegram_id, data)
    end
  end
end
