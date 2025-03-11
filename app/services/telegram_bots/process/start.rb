# frozen_string_literal: true

module TelegramBots
  module Process
    class Start < ApplicationService
      include TelegramParamsParser

      attr_reader :user

      def call(user)
        @user ||= user

        return unless user.may_start?

        TelegramBots::SendMessage.call(user:, bot:, text:, reply_markup: ReplyMarkup.new(bot).blank)

        ::TelegramBots::SetWebAppMenuButton.call(bot, user, bot.active_form)

        user.start!
      end

      private

      def bot
        @bot ||= user.bot
      end

      def text
        MessageTemplate.find_by(slug: 'start', bot:).text
      end
    end
  end
end
