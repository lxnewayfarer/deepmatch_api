# frozen_string_literal: true

module AI
  class YandexCloudResponse < ApplicationService
    def call(input_text, ai_context)
      YandexCloudAPI.new.completion(input_text, ai_context)
    end
  end
end
