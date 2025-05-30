# frozen_string_literal: true

module StateCommands
  class Support < StateProcessingService
    attr_reader :user

    def call(user)
      @user ||= user

      return unless user.state == 'main'

      TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'support', reply_markup: reply_markup('main'))
    end
  end
end
