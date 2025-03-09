# frozen_string_literal: true

class AddAIContextToBots < ActiveRecord::Migration[7.2]
  def change
    add_column :bots, :ai_context, :text
  end
end
