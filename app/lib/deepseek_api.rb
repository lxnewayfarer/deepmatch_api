# frozen_string_literal: true

class DeepseekAPI
  def initialize(token = nil)
    @token = token || ENV['DEEPSEEK_TOKEN']

    @base_url = 'https://api.deepseek.com'
    @conn = Faraday.new do |builder|
      builder.response :json, content_type: /\bjson$/
      builder.adapter Faraday.default_adapter
      builder.headers['Content-Type'] = 'application/json'
      builder.headers['Authorization'] = "Bearer #{@token}"
    end
  end

  def chat_completions(content, context)
    resp = @conn.post "#{@base_url}/chat/completions" do |req|
      req.body = {
        model: 'deepseek-chat',
        messages: [
          { role: 'system', content: context },
          { role: 'user', content: content }
        ],
        stream: false
      }.to_json
    end

    return 'Упс... Что-то пошло не так' unless resp.success?

    resp.body['choices'].first['message']['content']
  end
end
