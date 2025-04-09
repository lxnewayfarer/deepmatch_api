# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class Start < ApplicationService
        attr_reader :user

        def call(user)
          @user ||= user

          return unless user.state == 'initial'

          TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'start', reply_markup: ReplyMarkup.new(bot).fetch('main'))

          # ::TelegramBots::SetWebAppMenuButton.call(bot, user, bot.active_form)

          # ::Workflows::DemoStore::ChangeState.call(user:, state: 'started')
        end

        private

        def bot
          @bot ||= user.bot
        end
      end
    end
  end
end
