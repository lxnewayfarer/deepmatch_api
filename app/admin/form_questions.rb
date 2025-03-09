# frozen_string_literal: true

ActiveAdmin.register FormQuestion do
  permit_params :question, :slug, :kind, :form_id
end
