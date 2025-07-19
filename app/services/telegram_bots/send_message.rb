# frozen_string_literal: true

module TelegramBots
  class SendMessage < ApplicationService
    def call(user, message)
      SendMessageJob.new.perform(TelegramMessageFactory.call(user.telegram_id, message))
    end
  end
end
