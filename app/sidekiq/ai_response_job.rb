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

    TelegramBots::SendMessage.call(
      bot:,
      user:,
      text: response(bot, input_text),
      reply_markup: ReplyMarkup.new(bot).blank,
      ai_generated_response: true
    )
  end

  private

  def response(bot, input_text)
    AI_SERVICES[bot.tenant.ai_provider].call(input_text, bot.ai_context)
  end
end
