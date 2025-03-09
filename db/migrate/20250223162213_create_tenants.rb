# frozen_string_literal: true

class CreateTenants < ActiveRecord::Migration[7.2]
  def change
    create_table :tenants, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
