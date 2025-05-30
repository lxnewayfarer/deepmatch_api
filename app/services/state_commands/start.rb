# frozen_string_literal: true

module StateCommands
  class Start < StateProcessingService
    attr_reader :user

    def call(user)
      @user ||= user

      return unless user.state == 'initial'

      ::StateCommands::ChangeState.call(user:, state: 'main')

      TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'start', reply_markup: reply_markup('main'))
    end
  end
end
