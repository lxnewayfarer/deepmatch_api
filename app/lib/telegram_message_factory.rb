# frozen_string_literal: true

class TelegramMessageFactory
  class << self
    def call(telegram_user_id, text, reply_markup, photo = nil)
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
