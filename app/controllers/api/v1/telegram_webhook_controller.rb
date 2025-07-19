# frozen_string_literal: true

module API
  module V1
    class TelegramWebhookController < ::API::APIController
      def create
        TelegramBots::HandleMessage.call(params)

        render json: {}, status: :ok
      end
    end
  end
end
