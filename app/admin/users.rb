# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :telegram_id, :bot_id, :aasm_state

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    state_column :aasm_state
    column :telegram_id
    column :bot
    column :created_at

    actions
  end
end
