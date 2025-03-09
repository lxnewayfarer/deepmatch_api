# frozen_string_literal: true

ActiveAdmin.register Tenant do
  permit_params :name, :ai_provider
end
