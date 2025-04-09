# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :telegram_id, :bot_id, :state

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :state
    column :telegram_id
    column :bot
    column :created_at

    actions
  end
end
