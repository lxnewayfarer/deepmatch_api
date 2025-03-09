# frozen_string_literal: true

module Forms
  class FetchUserAnswer < ApplicationService
    def call(user:, slug:)
      FormAnswer
        .includes(form_question: :form)
        .find_by(
          form: { bot_id: user.bot.id },
          form_question: { slug: },
          user:
        )
        .answer
    end
  end
end
