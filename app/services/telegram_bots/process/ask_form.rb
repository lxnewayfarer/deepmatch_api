# frozen_string_literal: true

module TelegramBots
  module Process
    class AskForm < ApplicationService
      include TelegramParamsParser

      attr_reader :user

      def call(user)
        @user ||= user

        TelegramBots::SendMessage.call(user:, bot:, text:, reply_markup: ReplyMarkup.new(bot).blank)
      end

      private

      def bot
        @bot ||= user.bot
      end

      def text
        MessageTemplate.find_by(slug: 'ask_for_fill_the_form', bot:).text
      end
    end
  end
end
