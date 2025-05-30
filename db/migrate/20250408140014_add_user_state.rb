# frozen_string_literal: true

class AddUserState < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :state, :string, null: false, default: 'initial'
  end
end
