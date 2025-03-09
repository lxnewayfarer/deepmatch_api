# frozen_string_literal: true

class AddImageDataToMessageTemplates < ActiveRecord::Migration[7.2]
  def change
    add_column :message_templates, :image_data, :text
  end
end
