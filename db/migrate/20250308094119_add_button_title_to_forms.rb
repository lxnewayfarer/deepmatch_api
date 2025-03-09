# frozen_string_literal: true

class AddButtonTitleToForms < ActiveRecord::Migration[7.2]
  def change
    add_column :forms, :button_title, :string, null: false, default: 'Form'
  end
end
