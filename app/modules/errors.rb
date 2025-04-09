# frozen_string_literal: true

module Errors
  class DeepseekError < StandardError; end
  class TelegramRateLimitError < StandardError; end
  class BadRequestError < StandardError; end
  class YandexGPTError < StandardError; end

  class UnknownStateError < StandardError; end
end
