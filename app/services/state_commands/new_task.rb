# frozen_string_literal: true

module StateCommands
  class NewTask < StateProcessingService
    attr_reader :user

    def call(user)
      @user ||= user

      return unless user.state == 'main'

      ::StateCommands::ChangeState.call(user:, state: 'new_task')

      TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'new_task', reply_markup: reply_markup('new_task'))
    end
  end
end
