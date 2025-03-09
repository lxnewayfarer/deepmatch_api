# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :telegram_id, :bot_id, :aasm_state
end
