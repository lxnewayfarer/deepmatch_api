# frozen_string_literal: true

module StateCommands
  class StateProcessingService < ApplicationService
    def bot
      @bot ||= user.bot
    end

    def reply_markup(keyboard_name)
      ReplyMarkup.new(bot).send(keyboard_name)
    end
  end
end
