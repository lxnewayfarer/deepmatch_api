# frozen_string_literal: true

module TelegramBots
  class SetWebAppMenuButton < ApplicationService
    WEB_APP_MENU_BUTTON = { type: 'web_app' }.freeze

    def call(bot, user, form)
      menu_button = WEB_APP_MENU_BUTTON.merge(
        web_app: {
          url: form.url
        },
        text: form.button_title
      )
      ::TelegramAPI.new(bot.token).set_chat_menu_button(user.telegram_id, menu_button)
    end
  end
end
