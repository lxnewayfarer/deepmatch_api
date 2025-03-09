# frozen_string_literal: true

class TelegramWebhooksJob
  include Sidekiq::Job

  sidekiq_options retry: false, queue: 'default'

  def perform(data)
    params = JSON.parse(data)
    TelegramBots::HandleMessage.call(params)
  end
end
