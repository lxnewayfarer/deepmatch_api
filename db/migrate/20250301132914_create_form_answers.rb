# frozen_string_literal: true

class CreateFormAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :form_answers, id: :uuid do |t|
      t.string :answer
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :form_question, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
