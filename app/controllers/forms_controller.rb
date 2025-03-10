# frozen_string_literal: true

class FormsController < ApplicationController
  def show
    @form = form
  end

  def create
    Forms::ProcessFormConfirmation.call(
      user:,
      user_info:,
      bot:,
      answers_params: form_params[:form_answers_attributes]
    )

    success
  end

  private

  def bot
    @bot ||= form.bot
  end

  def user
    @user ||= User.find_by!(
      bot_id: bot.id,
      telegram_id: params['user_telegram_id']
    )
  end

  def user_info
    {
      username: params['username'],
      first_name: params['first_name'],
      last_name: params['last_name']
    }
  end

  def form_params
    params.require(:form).permit(:user_telegram_id, :username, :first_name, :last_name, :form_answers_attributes).to_h.deep_symbolize_keys
  end

  def form
    @form ||= Form.find(params[:id] || form_params[:id])
  end
end
