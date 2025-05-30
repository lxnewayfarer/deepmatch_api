# frozen_string_literal: true

module StateCommands
  class ToMain < StateProcessingService
    attr_reader :user

    def call(user)
      @user ||= user

      ::StateCommands::ChangeState.call(user:, state: 'main')

      TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'start', reply_markup: reply_markup('main'))
    end
  end
end
