# frozen_string_literal: true

class CreateAIContexts < ActiveRecord::Migration[7.2]
  def change
    create_table :ai_contexts, id: :uuid do |t|
      t.text :text
      t.references :bot, null: false, foreign_key: true, type: :uuid
      t.string :slug, null: false, default: 'main'
      t.timestamps
    end
  end
end
