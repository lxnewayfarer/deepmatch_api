# frozen_string_literal: true

class CreateFormQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :form_questions, id: :uuid do |t|
      t.string :question
      t.string :kind
      t.references :form, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
