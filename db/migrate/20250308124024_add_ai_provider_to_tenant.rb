# frozen_string_literal: true

class AddAIProviderToTenant < ActiveRecord::Migration[7.2]
  def change
    add_column :tenants, :ai_provider, :string, null: false, default: 'demo'
  end
end
