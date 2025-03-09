# frozen_string_literal: true

ActiveAdmin.register Tenant do
  permit_params :name
end
