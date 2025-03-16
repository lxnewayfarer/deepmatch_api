# frozen_string_literal: true

class SendQrCodeJob
  include Sidekiq::Job

  sidekiq_options retry: false, queue: 'default'

  def perform(token, chat_id, data, text)
    user = User.find_by(telegram_id: chat_id)
    bot = Bot.find_by(token:)

    temp_file = TelegramBots::GenerateQrTempFile.call(data)
    TelegramAPI.new(token).send_photo_multipart(chat_id, temp_file)
    TelegramBots::UpdateUserMessageResponse.call(user:, response: response(text))

    TelegramBots::SendMessage.call(bot:, user:, text:, reply_markup: ReplyMarkup.new(bot).main)
  end

  private

  def response(data)
    "[QR_CODE]: #{data}"
  end
end
