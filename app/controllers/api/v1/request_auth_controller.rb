# frozen_string_literal: true

module API
  module V1
    class RequestAuthController < ::API::APIController
      def index
        session_id = SecureRandom.uuid
        REDIS.set("tg_auth_requests_#{session_id}", 1, ex: 10.minutes)
        render json: { "uuid": session_id }, status: :ok
      end
    end
  end
end
