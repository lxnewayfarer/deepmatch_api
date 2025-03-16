# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class Contacts < ApplicationService
        attr_reader :user

        def call(user)
          @user ||= user

          TelegramBots::SendMessage.call(user:, bot:, text:, reply_markup: ReplyMarkup.new(bot).main)
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
