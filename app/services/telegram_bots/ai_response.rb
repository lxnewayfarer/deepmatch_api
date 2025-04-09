# frozen_string_literal: true

module TelegramBots
  class AIResponse < ApplicationService
    attr_reader :user

    def call(user, input_text)
      @user ||= user

      return if input_text.blank?

      TelegramBots::SendMessageTemplate.call(bot:, user:, slug: 'ai_wait_text', reply_markup: ReplyMarkup.new(bot).fetch(keyboard_name))

      AIResponseJob.perform_async(bot.id, user.id, input_text, ai_context)
    end

    private

    def ai_context
      user.bot.ai_contexts.find_by(slug: ai_context_slug).text
    end

    def ai_context_slug
      user.state == 'store_form_filled' ? 'store' : 'main'
    end

    def keyboard_name
      user.state == 'store_form_filled' ? 'store' : 'main'
    end

    def bot
      @bot ||= user.bot
    end
  end
end
