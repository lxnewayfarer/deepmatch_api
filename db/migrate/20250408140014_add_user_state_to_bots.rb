# frozen_string_literal: true

class AddUserStateToBots < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :aasm_state, :string
    add_column :users, :state, :string, null: false, default: 'initial'
  end
end
