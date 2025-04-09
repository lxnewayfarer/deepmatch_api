# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class Contacts < ApplicationService
        attr_reader :user

        def call(user)
          @user ||= user

          TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'contacts', reply_markup: ReplyMarkup.new(bot).fetch(keyboard_name))
        end

        private

        def keyboard_name
          user.state == 'form_filled' ? 'store' : 'main'
        end

        def bot
          @bot ||= user.bot
        end
      end
    end
  end
end
