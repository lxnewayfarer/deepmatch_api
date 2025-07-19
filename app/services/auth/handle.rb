# frozen_string_literal: true

module Auth
  class Handle < ApplicationService
    def call(user, session_id)
      session = find_session(session_id)
      Rails.logger.debug "Session: #{session}"
      return ::TelegramBots::SendMessage.call(user, 'Сессия истекла или недействительна. Попробуйте снова') if session.blank?

      verified_at = user.verified_at || DateTime.current
      secret_token = SecureRandom.base58(128)
      user.update!(secret_token:, verified_at:)

      ::TelegramBots::SendMessage.call(user, 'Вы авторизованы. Можете вернуться в приложение')
    end

    private

    def set_session(session_id, secret_token)
      REDIS.set("tg_auth_requests_#{session_id}", secret_token, ex: 2.minutes)
    end

    def find_session(session_id)
      REDIS.get("tg_auth_requests_#{session_id}")
    end
  end
end
