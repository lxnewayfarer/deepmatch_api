# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :telegram_id
      t.string :bot_id
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :aasm_state

      t.timestamps
    end
  end
end
