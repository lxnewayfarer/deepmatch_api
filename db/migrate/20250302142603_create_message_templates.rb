# frozen_string_literal: true

class CreateMessageTemplates < ActiveRecord::Migration[7.2]
  def change
    create_table :message_templates, id: :uuid do |t|
      t.string :slug
      t.string :text
      t.references :bot, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
