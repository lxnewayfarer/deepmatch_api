# frozen_string_literal: true

module TelegramBots
  class SendQrCode < ApplicationService
    def call(user:, data:)
      ::SendQrCodeJob.perform_async(user.bot.token, user.telegram_id, data)
    end
  end
end
