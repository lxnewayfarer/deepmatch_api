# frozen_string_literal: true

class SendMessageJob
  include Sidekiq::Job

  sidekiq_options retry: false, queue: 'default'

  def perform(messages)
    token = ENV['TELEGRAM_BOT_TOKEN']
    TelegramAPI.new(token).send_messages(messages)
  rescue Errors::TelegramRateLimitError => e
    self.class.perform_in(e.retry_after.to_i, messages)

    raise e
  end
end
