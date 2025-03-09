# frozen_string_literal: true

module Workflows
  module Demo
    module Process
      class PersonalizedNotification < ApplicationService
        attr_reader :user

        def call(user)
          @user = user

          ::TelegramBots::SendMessageTemplate.call(
            bot: user.bot,
            user: user,
            slug: 'personalized_notification',
            reply_markup: ReplyMarkup.new(user.bot).blank,
            params: {
              merch_title:,
              size:,
              name:
            }
          )
        end

        private

        def merch_title
          'OBEY Justice Everywhere heavyweight'
        end

        def name
          @name ||= ::Forms::FetchUserAnswer.call(user:, slug: 'name')
        end

        def size
          @size ||= ::Forms::FetchUserAnswer.call(user:, slug: 'size')
        end
      end
    end
  end
end
