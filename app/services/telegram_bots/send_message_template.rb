# frozen_string_literal: true

module TelegramBots
  class SendMessageTemplate < ApplicationService
    attr_reader :bot, :user, :slug, :photo_url, :params

    def call(bot:, user:, slug:, reply_markup:, photo_url: nil, params: {})
      @bot = bot
      @user = user
      @slug = slug
      @photo_url = photo_url
      @params = params

      TelegramBots::SendMessage.call(bot:, user:, text:, reply_markup:, photo:)
    end

    private

    def message_template
      @message_template ||= MessageTemplate.find_by(bot:, slug:)
    end

    def photo
      photo_url || message_template.full_image_url
    end

    def text
      return message_template.text % params if params.present?

      message_template.text
    end
  end
end
