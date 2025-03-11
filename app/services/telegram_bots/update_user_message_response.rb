# frozen_string_literal: true

module TelegramBots
  class UpdateUserMessageResponse < ApplicationService
    REDIS_KEY_PREFIX = 'user_message_response'

    def call(user:, response:, ai_generated_response:)
      message_id = REDIS.get(key(user))

      return if message_id.nil?

      Message.find(message_id).update!(response:, ai_generated_response:)
    end

    def key(user)
      "#{REDIS_KEY_PREFIX}:#{user.id}"
    end
  end
end
