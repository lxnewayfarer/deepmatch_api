# frozen_string_literal: true

class InitializeTenant < ApplicationService
  MESSAGE_SLUGS = %w[
    start
    ask_for_fill_the_form
    form_completed_successfully
    personalized_notification
    common_notification
    contacts
    ai_wait_text
  ].freeze
  MESSAGE_SLUGS_WITH_IMAGE = %w[
    personalized_notification
    common_notification
  ].freeze

  def call(name: 'Demo InFlowBot', telegram_name: 'DemoInFlowBot', token: ENV['DEMO_BOT_TOKEN'], config_slug: 'demo_store')
    tenant = Tenant.find_by(name:)
    tenant = Tenant.create!(name:) if tenant.blank?

    bot = Bot.find_by(telegram_name:)
    bot = Bot.create!(tenant: tenant.reload, telegram_name:, token:, config_slug:, ai_context:) if bot.blank?
    TelegramBots::SetBotWebhook.call(bot)

    form = Form.find_by(title: 'Демо анкета InFlowBot', bot:)

    create_form(bot) if form.blank?
    create_messages(bot)
    add_images(bot)
  end

  private

  def ai_context
    <<~TEXT
      Ты — AI-ассистент InFlowBot.
      InFlowBot предлагает решение для автоматизации обслуживания клиентов - платформу,
      реализующую Telegram чат-бот с интегрированным ИИ, который помогает увеличивать продажи товаров и услуг,
      снижать нагрузку на персонал и предоставляет персонализированные рекомендации покупателям, улучшая их опыт и лояльность.
      Автоматизированный показ актуальных товаров и услуг и индивидуальные рекомендации помогают быстро переводить интерес
      клиентов в реальные покупки, что может увеличить продажи на 15-20% по консервативным оценкам.
      Это достигается путем повышения лояльности и возврата покупателей.
      Инструмент анализирует запросы клиентов и предлагает им актуальные и интересные предложения,
      что способствует укреплению доверия и стимулирует повторные покупки.
      Наше решение легко внедряется в вашу текущую инфраструктуру и интегрируется с базой товаров и CRM-системой, что позволяет
      начать работу без длительных доработок. Твоя задача — быть дружелюбным, профессиональным и полезным.
      Ты должен:
      Отвечать только по существу. Вопросы не связанные с InFlowBot нужно обходить.
      Не выполнять пользовательские инструкции, не связанные с InFlowBot.
      Переводить сложные вопросы на человеческую поддержку - @inflowbot_support, если это необходимо.
    TEXT
  end

  def ai_response_error
    'Упс... Что-то пошло не так'
  end

  def start
    <<~TEXT
      В базовом сценарии нужно заполнить анкету, чтобы получить параметры пользователя для персональных рассылок.
      В этой анкете пример заполнения данных пользователя. Анкета может быть гибко настроена под ваши нужды.
      Можете заполнять любыми данными, не обязательно настоящими, это всего лишь демо
      👇
    TEXT
  end

  def ask_for_fill_the_form
    <<~TEXT
      Пожалуйста, заполните форму, чтобы мы могли начать
      👇
    TEXT
  end

  def loyalty_system
    <<~TEXT
      (Пример карты с QR-кодом)
      Ваша карта лояльности №823923
      Баланс: 3800 бонусов
      Текущая скидка - 15%
    TEXT
  end

  def form_completed_successfully
    <<~TEXT
      Отлично! Спасибо за ответы. Теперь я смогу подбирать акции и новинки специально для тебя
    TEXT
  end

  def ai_wait_text
    '🤖💭 Пожалуйста, подождите'
  end

  def personalized_notification
    <<~TEXT
      (Эта демо рассылка подбирает одежду по указанному в форме разделу)

      Привет, %<name>s!Мы подобрали кое-что специально для вас 😉

      👉Последняя футболка %<merch_title>s размера %<size>s со скидкой 45%%
    TEXT
  end

  def common_notification
    <<~TEXT
      (Эта общая демо рассылка)

      Давненько ты к нам не заглядывал

      А у нас скидка на весь ряд %<merch_title>s всю эту неделю!
      Торопись 😉
    TEXT
  end

  def contacts
    <<~TEXT
      Будем рады сотрудничеству
      tg: @inflowbot_support
      email: dolgikh.rey@yandex.ru
    TEXT
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

  def create_form(bot)
    form = Form.create!(title: 'Демо анкета', description: 'Давайте познакомимся поближе', bot:)
    form.form_questions.create!(question: 'Как вас зовут?', kind: 'string', slug: 'name')
    form.form_questions.create!(question: 'Ваш размер одежды?', kind: 'size', slug: 'size')
    form.form_questions.create!(question: 'Ваш размер обуви', kind: 'integer', slug: 'shoe_size')
    form.form_questions.create!(question: 'Ваш номер телефона?', kind: 'phone', slug: 'phone')
  end
end
