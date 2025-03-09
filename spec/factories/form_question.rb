# frozen_string_literal: true

FactoryBot.define do
  factory :form_question do
    question { 'What is your name?' }
    kind { 'string' }
  end
end
