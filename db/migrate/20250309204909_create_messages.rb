# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.string :text
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
