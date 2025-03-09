# frozen_string_literal: true

class AddConfigSlugToBots < ActiveRecord::Migration[7.2]
  def change
    add_column :bots, :config_slug, :string
  end
end
