# frozen_string_literal: true

ActiveAdmin.register Bot do
  permit_params :description, :token, :tenant_id, :telegram_name, :ai_context, :config_slug

  index do
    selectable_column
    id_column
    column :telegram_name
    column :description
    tag_column :config_slug

    actions
  end

  # Добавляем кастомное действие для установки вебхука
  action_item :set_webhook, only: :show do
    link_to 'Set Webhook', set_webhook_admin_bot_path(bot), method: :post
  end

  member_action :set_webhook, method: :post do
    bot = Bot.find(params[:id])
    TelegramBots::SetBotWebhook.call(bot)
    redirect_to admin_bot_path(bot), notice: 'Webhook has been set successfully!'
  end
end
