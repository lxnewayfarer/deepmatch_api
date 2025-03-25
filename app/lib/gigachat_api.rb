# frozen_string_literal: true

class GigachatAPI
  FARADAY_TIMEOUT = 20.seconds

  def initialize(token = nil)
    @token = token || ENV['GIGACHAT_TOKEN']

    @base_url = 'https://gigachat.devices.sberbank.ru'
    @conn = Faraday.new do |builder|
      builder.options.timeout = FARADAY_TIMEOUT
      builder.response :json, content_type: /\bjson$/
      builder.adapter Faraday.default_adapter
      builder.headers['Content-Type'] = 'application/json'
      builder.headers['Authorization'] = "Bearer #{@token}"
    end
  end

  # https://developers.sber.ru/studio/workspaces/7cad4e39-cadb-4aed-adad-d627d6a1e421/gigachat-api/projects/5aa75a4e-00bd-492b-96fe-92cfccbb1967/settings
  def oauth
    resp = @conn.post "#{@base_url}/api/v2/oauth" do |req|
      req.body = {
        model: 'GigaChat-2',
        messages: [
          { role: 'system', content: context },
          { role: 'user', content: content }
        ],
        stream: false
      }.to_json
    end

    resp.body
  end

  def chat_completions(content, context)
    resp = @conn.post "#{@base_url}/api/v1/chat/completions" do |req|
      req.body = {
        model: 'GigaChat-2',
        messages: [
          { role: 'system', content: context },
          { role: 'user', content: content }
        ],
        stream: false
      }.to_json
    end

    raise Errors::DeepseekError, resp.body unless resp.success?

    resp.body['choices'].first['message']['content']
  end
end
