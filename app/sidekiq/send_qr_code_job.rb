# frozen_string_literal: true

class SendQrCodeJob
  include Sidekiq::Job

  sidekiq_options retry: false, queue: 'default'

  def perform(token, chat_id, data)
    temp_file = TelegramBots::GenerateQrTempFile.call(data)
    TelegramAPI.new(token).send_photo_multipart(chat_id, temp_file)
  end
end
