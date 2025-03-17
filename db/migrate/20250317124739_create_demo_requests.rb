# frozen_string_literal: true

class CreateDemoRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :demo_requests, id: :uuid do |t|
      t.string :name
      t.string :contact
      t.string :company

      t.timestamps
    end
  end
end
