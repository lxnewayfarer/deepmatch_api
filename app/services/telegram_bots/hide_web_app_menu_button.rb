# frozen_string_literal: true

module TelegramBots
  class HideWebAppMenuButton < ApplicationService
    COMMANDS_MENU_BUTTON = { type: 'commands' }.freeze

    def call(bot, user)
      ::TelegramAPI.new(bot.token).set_chat_menu_button(user.telegram_id, COMMANDS_MENU_BUTTON)
    end
  end
end
