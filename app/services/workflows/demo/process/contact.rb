# frozen_string_literal: true

module Workflows
  module Demo
    module Process
      class Contact < ApplicationService
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
          MessageTemplate.find_by(slug: 'contacts', bot:).text
        end
      end
    end
  end
end
