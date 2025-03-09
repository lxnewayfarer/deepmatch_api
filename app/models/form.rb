# frozen_string_literal: true

class Form < ApplicationRecord
  has_many :form_questions, dependent: :destroy
  belongs_to :bot

  accepts_nested_attributes_for :form_questions, allow_destroy: true
end
