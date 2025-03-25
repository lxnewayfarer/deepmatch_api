# frozen_string_literal: true

class YandexCloudAPI
  FARADAY_TIMEOUT = 20.seconds

  def initialize(token = nil)
    @token = token || ENV['YANDEX_TOKEN']

    @base_url = 'https://llm.api.cloud.yandex.net/foundationModels'
    @yandex_catalog_id = ENV['YANDEX_CATALOG_ID']

    @conn = Faraday.new do |builder|
      builder.options.timeout = FARADAY_TIMEOUT
      builder.response :json, content_type: /\bjson$/
      builder.adapter Faraday.default_adapter
      builder.headers['Content-Type'] = 'application/json'
      builder.headers['Authorization'] = "Api-Key #{@token}"
    end
  end

  # https://yandex.cloud/ru/docs/foundation-models/quickstart/yandexgpt#api_1
  def completion(content, context)
    resp = @conn.post "#{@base_url}/v1/completion" do |req|
      req.body = {
        modelUri: "gpt://#{@yandex_catalog_id}/yandexgpt-lite/latest",

        completionOptions: {
          stream: false,
          temperature: 0.7,
          maxTokens: '2000',
          reasoningOptions: {
            mode: 'DISABLED'
          }
        },
        messages: [
          { role: 'system', text: context },
          { role: 'user', text: content }
        ],
        stream: false
      }.to_json
    end

    raise Errors::YandexGPTError, resp.body unless resp.success?

    resp.body['result']['alternatives'].first['message']['text']
  end
end
