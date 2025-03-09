# frozen_string_literal: true

module API
  module V1
    class TelegramWebhooksController < ::API::APIController
      def create
        ::TelegramWebhooksJob.perform_async(message_params.to_json)

        success
      end

      def message_params
        params[:telegram_webhook].merge(bot_id: params[:bot_id])
      end
    end
  end
end
