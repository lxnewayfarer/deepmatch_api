# frozen_string_literal: true

module DemoRequests
  class CreateDemoRequest < ApplicationService
    def call(params)
      DemoRequest.create!(params)

      user = User.find_by(telegram_id: ENV['ADMIN_TELEGRAM'])

      TelegramBots::SendMessage.call(
        user:,
        bot: user.bot,
        reply_markup: ReplyMarkup.new(user.bot).blank,
        text: "NEW DEMO REQUEST:\n\n#{params.values.join("\n")}"
      )
    end
  end
end
