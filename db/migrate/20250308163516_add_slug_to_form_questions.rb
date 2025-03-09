# frozen_string_literal: true

class AddSlugToFormQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :form_questions, :slug, :string
  end
end
