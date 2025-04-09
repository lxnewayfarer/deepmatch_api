# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class Contacts < WorkflowService
        attr_reader :user

        def call(user)
          @user ||= user

          TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'contacts', reply_markup: reply_markup('main'))
        end
      end
    end
  end
end
