# frozen_string_literal: true

module TelegramBots
  class UpdateUserMessageResponse < ApplicationService
    REDIS_KEY_PREFIX = 'user_message_response'

    def call(user:, response:, ai_generated_response:)
      message_id = REDIS.get(key(user))

      return if message_id.nil?

      message = Message.find(message_id)

      message.update!(response: concat_responses(message, response), ai_generated_response:)
    end

    private

    def concat_responses(message, response)
      return response if message.response.blank?

      "#{message.response}\n#{response}"
    end

    def key(user)
      "#{REDIS_KEY_PREFIX}:#{user.id}"
    end
  end
end
