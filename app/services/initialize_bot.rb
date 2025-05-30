# frozen_string_literal: true

class InitializeBot < ApplicationService
  MESSAGE_SLUGS = %w[
    start
  ].freeze
  MESSAGE_SLUGS_WITH_IMAGE = %w[].freeze

  def call(telegram_name: 'Procrastinator_AI_bot', token: ENV['DEMO_BOT_TOKEN'])
    bot = Bot.find_by(telegram_name:)
    bot = Bot.create!(telegram_name:, token:) if bot.blank?
    AIContext.create!(text: ai_context_create_notifications, slug: 'create_notifications', bot:)
    TelegramBots::SetBotWebhook.call(bot)

    create_messages(bot)
    add_images(bot)
  end

  private

  def start
    'Hello'
  end

  def ai_context_create_notifications
    <<~TEXT
      Ты исполняешь роль проектного менеджера.
      Напиши json с расписанием уведомлений исполнителя - меня, по заданному описанию.
      Json в формате {"message", "sends_at"}.
      В твоем ответе должен быть только JSON. Время в формате iso

      Вот задача:\n
    TEXT
  end

  def ai_response_error
    'Упс... Что-то пошло не так'
  end

  def create_messages(bot)
    MESSAGE_SLUGS.each do |slug|
      MessageTemplate.create!(
        bot:,
        slug:,
        text: send(slug)
      )
    end
  end

  def add_images(bot)
    MESSAGE_SLUGS_WITH_IMAGE.each do |slug|
      message_template = MessageTemplate.find_by(slug:, bot:)
      file = File.open("public/#{slug}.jpg")
      message_template.update!(image: file)
    end
  end
end
