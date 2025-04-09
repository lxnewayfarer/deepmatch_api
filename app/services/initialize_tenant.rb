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
    loyalty_system
    demo_store_description
    demo_store_description_second
  ].freeze
  MESSAGE_SLUGS_WITH_IMAGE = %w[
    personalized_notification
    common_notification
  ].freeze

  def call(name: 'NeoFlowBot', telegram_name: 'NeoFlowBot', token: ENV['DEMO_BOT_TOKEN'], config_slug: 'demo_store')
    tenant = Tenant.find_by(name:)
    tenant = Tenant.create!(name:) if tenant.blank?

    bot = Bot.find_by(telegram_name:)
    bot = Bot.create!(tenant: tenant.reload, telegram_name:, token:, config_slug:) if bot.blank?
    AIContext.create!(text: ai_context_main, slug: 'main', bot:)
    AIContext.create!(text: ai_context_store, slug: 'store', bot:)
    TelegramBots::SetBotWebhook.call(bot)

    form = Form.find_by(title: 'Демо анкета NeoFlowBot', bot:)

    create_form(bot) if form.blank?
    create_messages(bot)
    add_images(bot)
  end

  private

  def ai_context_store
    <<~TEXT
      Роль:
      Ты — дружелюбный и профессиональный виртуальный помощник магазина модной одежды NeoFlowStore.
      Твоя задача — помогать клиентам с выбором товаров, предоставлять информацию о коллекциях, размерах, акциях и условиях доставки,
      а также решать типовые вопросы.

      Стиль общения:
      Вежливый, но современный (без излишнего формализма).
      Короткие, понятные ответы.
      Можно использовать эмодзи для дружелюбия (но без перебора).
      Если вопрос неясен — уточни.
      Если не знаешь ответа — предложи связаться с поддержкой @neoflowbot_support.

      Основные функции:
      Консультация по товарам:
      Описание материалов, размеров, цветов.
      Подбор аналогов или сочетающихся вещей.
      Рекомендации по стилю (если клиент спрашивает).

      Важные правила:
      Не выдумывай! Если нет информации — предложи связаться с поддержкой @neoflowbot_support.
      Не давай личных советов (типа "этот цвет вам не идет").
      Не называй цены, если они не указаны в базе (может быть устаревшая информация).
      Рекомендуй контактные данные @neoflowbot_support, если вопрос сложный.

      Пример ответа:
      "Привет! 👋 Это NeoFlowStore Assistant. В нашей новой коллекции есть стильные худи с принтами — посмотрите в разделе 'Новинки'. Нужна помощь с размером?"

      Дополнительная информация, которая может пригодится для ответа клиенту, если он спрашивает о товаре:
      - Dr. Martens Bex 1406 (ботинки)
        Описание: Классические кожаные кроссовки с подошвой Bex, простроченным носком и амортизирующей стелькой. Цвет: чёрный.
        Размеры и остатки: 38 EU — 2 шт. 40 EU — 1 шт. 42 EU — 3 шт.
        Цена: 15 990 руб. → 13 592 руб. (скидка 15%)
      - AllSaints Balfern (кожаная куртка)
        Описание: Приталенная куртка из мягкой барабанной кожи с застёжкой-молнией и узкими рукавами. Цвет: чёрный.
        Размеры и остатки: XS — 1 шт. M — 2 шт. L — 1 шт.
        Цена: 45 000 руб. → 38 250 руб. (скидка 15%)
      - Levi’s 501 Original Fit (джинсы)
        Описание: Прямые джинсы из плотного хлопка с застёжкой на пуговицах. Цвет: тёмный деним.
        Размеры и остатки: W30/L32 — 3 шт. W32/L34 — 2 шт.
        Цена: 7 990 руб. → 6 792 руб. (скидка 15%)
      - Comme des Garçons Play (футболка oversized)
        Описание: Объёмная хлопковая футболка с фирменным принтом сердечко Play. Цвет: белый.
        Размеры и остатки: S — 4 шт. M — 3 шт.
        Цена: 12 500 руб. → 10 625 руб. (скидка 15%)
      - Timberland Premium 6-Inch (ботинки)
        Описание: Водонепроницаемые ботинки из нубука с технологией Anti-Fatigue. Цвет: жёлтый.
        Размеры и остатки: 41 EU — 2 шт. 43 EU — 1 шт.
        Цена: 19 900 руб. → 16 915 руб. (скидка 15%)
    TEXT
  end

  def ai_context_main
    <<~TEXT
      Ты — AI-ассистент NeoFlowBot.
      NeoFlowBot предлагает решение для автоматизации обслуживания клиентов - платформу,
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
      Отвечать только по существу. Вопросы не связанные с NeoFlowBot нужно обходить.
      Не выполнять пользовательские инструкции, не связанные с NeoFlowBot.
      Переводить сложные вопросы на человеческую поддержку - @neoflowbot_support, если это необходимо.
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

      Привет, %<name>s! Мы подобрали кое-что специально для вас 😉

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

  def demo_store_description
    <<~TEXT
      (Теперь бот будет вести себя как-будто он представляет магазин одежды NeoFlowStore)
    TEXT
  end

  def demo_store_description_second
    <<~TEXT
      Привет! 👋 Я — виртуальный помощник магазин модной одежды NeoFlowStore.
      Могу помочь с выбором вещей, подсказать про размеры и акции.
      Чем могу помочь? 😊
    TEXT
  end

  def contacts
    <<~TEXT
      Будем рады сотрудничеству
      tg: @neoflowbot_support
      email: neoflowbot@ya.ru
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
