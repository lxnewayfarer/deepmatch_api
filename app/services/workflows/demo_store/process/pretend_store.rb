# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class PretendStore < ApplicationService
        attr_reader :user

        def call(user)
          @user = user

          ::TelegramBots::SendMessageTemplate.call(
            bot: user.bot,
            user: user,
            slug: 'demo_store_description',
            reply_markup: ReplyMarkup.new(user.bot).remove
          )

          ::TelegramBots::SetWebAppMenuButton.call(bot, user, bot.active_form)
          ::Workflows::DemoStore::ChangeState.call(user:, state: 'store')
        end

        private

        def bot
          @bot ||= user.bot
        end
      end
    end
  end
end
