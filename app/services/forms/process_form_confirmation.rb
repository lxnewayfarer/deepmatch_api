# frozen_string_literal: true

module Forms
  class ProcessFormConfirmation < ApplicationService
    def call(user:, user_info:, answers_params:, bot:)
      create_answers(answers_params, user)

      TelegramBots::SendMessageTemplate.call(
        bot:,
        user:,
        text: form_response_message(bot),
        reply_markup: ReplyMarkup.new(bot).main
      )
      TelegramBots::HideWebAppMenuButton.call(bot, user)

      update_user_info(user, user_info)
    end

    private

    def form_response_message(bot)
      MessageTemplate.find_by!(slug: 'form_completed_successfully', bot:).text
    end

    def create_answers(answers_params, user)
      answers_params.each do |attrs|
        form_answer = FormAnswer.find_or_initialize_by(
          user:,
          form_question_id: attrs[:form_question_id]
        )
        form_answer.update!(answer: attrs[:answer])
      end
    end

    def update_user_info(user, user_info)
      user.update!(user_info)
      user.confirm_form!
    end
  end
end
