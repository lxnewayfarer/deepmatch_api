# frozen_string_literal: true

class CreateBots < ActiveRecord::Migration[7.2]
  def change
    create_table :bots, id: :uuid do |t|
      t.string :webhook_url
      t.text :description
      t.string :token, null: false
      t.references :tenant, null: false, foreign_key: true, type: :uuid
      t.string :telegram_name, null: false

      t.timestamps
    end
  end
end
