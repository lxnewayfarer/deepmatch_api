# frozen_string_literal: true

class TelegramAPI
  class BadRequestError < StandardError; end

  RETRY_AFTER = 5.seconds

  def initialize(token = nil)
    @token = token

    @telegram_base_url = "https://api.telegram.org/bot#{@token}"
    @conn = Faraday.new do |builder|
      builder.response :json, content_type: /\bjson$/
      builder.adapter Faraday.default_adapter
      builder.headers['Content-Type'] = 'application/json'
    end
  end

  def bot_link(name)
    "https://t.me/#{name}?start="
  end

  def to_markdown(message)
    message.merge(parse_mode: 'Markdown').to_json.gsub('**', '*')
  end

  def send_messages(messages)
    messages.each do |message|
      method_name = 'sendMessage'

      method_name = 'sendPhoto' if message['photo'].present?

      resp = @conn.post "#{@telegram_base_url}/#{method_name}" do |req|
        req.body = to_markdown(message)
      end

      process_error(resp) if resp.body['ok'] == false
    end
  end

  def get_chat_menu_button(chat_id)
    resp = @conn.get "#{@telegram_base_url}/getChatMenuButton" do |req|
      req.body = { chat_id: }.to_json
    end

    resp.body
  end

  def set_chat_menu_button(chat_id, menu_button)
    resp = @conn.post "#{@telegram_base_url}/setChatMenuButton" do |req|
      req.body = { chat_id:, menu_button: }.to_json
    end

    resp.body
  end

  def process_error(resp)
    if resp.body['error_code'] == 429
      raise Exceptions::RateLimitError.new(
        message: resp.body['description'],
        retry_after: RETRY_AFTER
      )
    end

    raise BadRequestError, resp.body
  end

  def set_webhook(endpoint)
    return if Rails.env.test?

    resp = @conn.post("#{@telegram_base_url}/setWebhook") do |req|
      req.body = { url: endpoint }.to_json
    end

    Rails.logger.info "[Telegram] - status: #{resp.status}, body: #{resp.body}" unless Rails.env.production?

    resp.body
  end

  def delete_webhook
    return if Rails.env.test?

    resp = @conn.post("#{@telegram_base_url}/deleteWebhook")

    Rails.logger.info "[Telegram] - status: #{resp.status}, body: #{resp.body}" unless Rails.env.production?

    resp.body
  end
end
