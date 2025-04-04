# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class LoyaltySystem < ApplicationService
        attr_reader :user

        def call(user)
          @user ||= user

          TelegramBots::SendQrCode.call(user:, data:, text:)
        end

        private

        def data
          'https://t.me/DemoNeoFlowBot'
        end

        def text
          MessageTemplate.find_by(slug: 'loyalty_system', bot: user.bot).text
        end
      end
    end
  end
end
