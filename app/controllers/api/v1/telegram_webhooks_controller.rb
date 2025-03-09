# frozen_string_literal: true

module API
  module V1
    class TelegramWebhooksController < ::API::APIController
      def create
        ::TelegramWebhooksJob.perform_async(params.to_json)

        success
      end
    end
  end
end
