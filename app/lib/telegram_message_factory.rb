# frozen_string_literal: true

# TelegramMessageFactory.call(5365087260, "123")
class TelegramMessageFactory
  class << self
    def call(telegram_user_id, text, reply_markup = ReplyMarkup.blank, photo = nil)
      return [{ chat_id: telegram_user_id, caption: text, reply_markup:, photo: }] if photo.present?

      [
        {
          chat_id: telegram_user_id,
          reply_markup:,
          text:
        }
      ]
    end
  end
end
