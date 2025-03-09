# frozen_string_literal: true

class CreateForms < ActiveRecord::Migration[7.2]
  def change
    create_table :forms, id: :uuid do |t|
      t.string :title
      t.text :description
      t.text :private_comment
      t.references :bot, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
