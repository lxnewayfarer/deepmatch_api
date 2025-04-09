# frozen_string_literal: true

module Workflows
  class WorkflowService < ApplicationService
    def bot
      @bot ||= user.bot
    end

    def reply_markup(keyboard_name)
      ReplyMarkup.new(bot).fetch(keyboard_name)
    end
  end
end
