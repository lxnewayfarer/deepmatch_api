# frozen_string_literal: true

module AI
  class DeepseekResponse < ApplicationService
    def call(input_text, ai_context)
      DeepseekAPI.new.chat_completions(input_text, ai_context)
    rescue StandardError => e
      Rollbar.error(e)

      'Упс... Что-то пошло не так'
    end
  end
end
