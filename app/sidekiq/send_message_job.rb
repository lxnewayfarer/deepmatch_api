# frozen_string_literal: true

class SendMessageJob
  include Sidekiq::Job

  sidekiq_options retry: false, queue: 'default'

  def perform(token, messages)
    messages = JSON.parse(messages)
    TelegramAPI.new(token).send_messages(messages)
  end
end
