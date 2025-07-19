# frozen_string_literal: true

module API
  module V1
    class VerifyAuthController < ::API::APIController
      def create
        Rails.logger.debug 'params'
        Rails.logger.debug params.permit(:session_uuid).to_h

        result = REDIS.get("tg_auth_requests_#{params.permit(:session_uuid)[:session_uuid]}")
        Rails.logger.debug "Result: #{result}"
        result = nil if result == 1
        render json: { "secret_token": result }, status: :ok
      end
    end
  end
end
