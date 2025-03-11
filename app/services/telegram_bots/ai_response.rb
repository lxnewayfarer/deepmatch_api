# frozen_string_literal: true

module TelegramBots
  class AIResponse < ApplicationService
    include TelegramParamsParser

    attr_reader :user

    def call(user, input_text)
      @user ||= user

      TelegramBots::SendMessageTemplate.call(bot:, user:, slug: 'ai_wait_text', reply_markup: ReplyMarkup.new(bot).blank)

      AIResponseJob.perform_async(bot.id, user.id, input_text)
    end

    private

    def bot
      @bot ||= user.bot
    end
  end
end
