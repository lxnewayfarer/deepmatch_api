# frozen_string_literal: true

module TelegramBots
  class AIResponse < ApplicationService
    include TelegramParamsParser

    attr_reader :user, :input_text

    AI_SERVICES = {
      'demo' => ::AI::DemoResponse,
      'deepseek' => ::AI::DeepseekResponse
    }.freeze

    def call(user, input_text)
      @user ||= user
      @input_text ||= input_text

      send_wait_text

      messages = TelegramMessageFactory.call(user.telegram_id, text, ReplyMarkup.new(bot).blank)
      ::SendMessageJob.perform_async(bot.token, messages.to_json)
    end

    private

    def send_wait_text
      TelegramBots::SendMessageTemplate.call(bot:, user:, slug: 'ai_wait_text', reply_markup: ReplyMarkup.new(bot).blank)
    end

    def bot
      @bot ||= user.bot
    end

    def ai_provider
      @ai_provider ||= bot.tenant.ai_provider
    end

    def ai_context
      @ai_context ||= bot.ai_context
    end

    def text
      AI_SERVICES[ai_provider].call(input_text, ai_context)
    end
  end
end
