# frozen_string_literal: true

class SendMessageJob
  include Sidekiq::Job

  sidekiq_options retry: false, queue: 'default'

  def perform(token, messages, user_id, response, ai_generated_response)
    messages = JSON.parse(messages)
    TelegramAPI.new(token).send_messages(messages)

    TelegramBots::UpdateUserMessageResponse.call(user: User.find(user_id), response:, ai_generated_response:)
  end
end
