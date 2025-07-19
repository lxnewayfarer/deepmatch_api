# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :sex
      t.date :birthday
      t.string :telegram_id
      t.string :secret_token
      t.timestamp :verified_at

      t.timestamps
    end
  end
end
