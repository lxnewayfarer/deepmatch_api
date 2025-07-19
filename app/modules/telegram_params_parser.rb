# frozen_string_literal: true

module TelegramParamsParser
  def text
    @text ||= params['message']['text']
  end

  def start_command_with_context?
    return false if text.blank?

    text.scan(%r{/start\s.*})[0].present?
  end

  def start_command?
    return false if text.blank?

    text == '/start'
  end

  def start_context
    @start_context ||= start_command_with_context? ? text.split[1] : nil
  end

  def telegram_id
    @telegram_id ||= params.dig('message', 'from', 'id') || params.dig('callback_query', 'from', 'id')
  end

  def user
    @user ||= User.find_or_create_by!(telegram_id:)
  end
end
