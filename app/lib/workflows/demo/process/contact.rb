# frozen_string_literal: true

module Workflows
  module Demo
    module Process
      class Contact < ApplicationService
        attr_reader :user

        def call(user)
          @user ||= user

          messages = TelegramMessageFactory.call(user.telegram_id, text, ReplyMarkup.new(bot).blank)

          ::SendMessageJob.perform_async(user.bot.token, messages.to_json)
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
