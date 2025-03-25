# frozen_string_literal: true

class AIResponseJob
  include Sidekiq::Job

  sidekiq_options retry: false, queue: 'default'

  AI_SERVICES = {
    'demo' => ::AI::DemoResponse,
    'deepseek' => ::AI::DeepseekResponse
  }.freeze

  def perform(bot_id, user_id, input_text)
    bot = Bot.find(bot_id)
    user = User.find(user_id)

    send_response(bot:, user:, input_text:)
  end

  private

  def send_response(bot:, user:, input_text:)
    text = AI_SERVICES[bot.tenant.ai_provider].call(input_text, bot.ai_context)

    TelegramBots::SendMessage.call(
      bot:,
      user:,
      text:,
      reply_markup: ReplyMarkup.new(bot).blank,
      ai_generated_response: true
    )
  rescue StandardError => e
    Rollbar.error(e)

    TelegramBots::SendMessageTemplate.call(bot:, user:, slug: 'ai_response_error', reply_markup: ReplyMarkup.new(bot).blank)
  end
end
