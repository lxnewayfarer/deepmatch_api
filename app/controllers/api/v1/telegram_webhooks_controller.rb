# frozen_string_literal: true

module API
  module V1
    class TelegramWebhooksController < ::API::APIController
      def create
        ::TelegramWebhooksJob.perform_async(params[:telegram_webhook].to_json)

        success
      end
    end
  end
end
