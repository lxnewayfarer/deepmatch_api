# frozen_string_literal: true

class FormAnswer < ApplicationRecord
  belongs_to :form_question
  belongs_to :user
end
