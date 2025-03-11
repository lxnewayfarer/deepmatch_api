# frozen_string_literal: true

module TelegramBots
  class SetUserMessageResponse < ApplicationService
    REDIS_KEY_PREFIX = 'user_message_response'

    def call(user:, message:)
      REDIS.set(key(user), message.id, ex: 3.minutes)
    end

    def key(user)
      "#{REDIS_KEY_PREFIX}:#{user.id}"
    end
  end
end
