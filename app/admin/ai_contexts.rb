# frozen_string_literal: true

ActiveAdmin.register AIContext do
  permit_params :slug, :bot_id, :text
end
