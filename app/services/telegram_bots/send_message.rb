# frozen_string_literal: true

module TelegramBots
  class SendMessage < ApplicationService
    def call(bot:, user:, text:, reply_markup:, photo: nil, ai_generated_response: false)
      messages = TelegramMessageFactory.call(user.telegram_id, text, reply_markup, photo)

      ::SendMessageJob.perform_async(bot.token, messages.to_json, user.id, response(text, photo), ai_generated_response)
    end

    private

    def response(text, photo)
      return text if photo.blank?

      "#{text}\n#{photo}"
    end
  end
end
