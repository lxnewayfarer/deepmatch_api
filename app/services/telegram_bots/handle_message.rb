# frozen_string_literal: true

module TelegramBots
  class HandleMessage < ApplicationService
    include TelegramParamsParser

    attr_reader :params

    def call(params)
      @params = params

      "Workflows::#{bot.config_slug.camelize}::HandleMessage".constantize.call(params)
    end
  end
end
