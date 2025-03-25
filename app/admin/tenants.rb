# frozen_string_literal: true

ActiveAdmin.register Tenant do
  permit_params :name, :ai_provider

  form do |f|
    f.inputs do
      f.input :name
      f.input :ai_provider
    end

    f.actions
  end
end
