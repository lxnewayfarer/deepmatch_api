# frozen_string_literal: true

ActiveAdmin.register Bot do
  permit_params :webhook_url, :description, :token, :tenant_id, :telegram_name, :ai_context, :config_slug
end
