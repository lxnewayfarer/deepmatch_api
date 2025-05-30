# frozen_string_literal: true

module StateCommands
  class TasksList < StateProcessingService
    attr_reader :user

    def call(user)
      @user ||= user

      return unless user.state == 'main'

      TelegramBots::SendMessageTemplate.call(user:, bot:, slug: 'tasks_list', reply_markup: reply_markup('main'))
    end
  end
end
