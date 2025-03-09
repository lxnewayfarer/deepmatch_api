# frozen_string_literal: true

ActiveAdmin.register FormQuestion do
  permit_params :question, :slug, :kind, :form_id

  index do
    selectable_column
    id_column
    column :question
    tag_column :kind
    column :form
    column :slug
    column :created_at

    actions
  end
end
