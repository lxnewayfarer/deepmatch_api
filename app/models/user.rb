# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :bot
  has_many :messages, dependent: :destroy
  has_many :form_answers, dependent: :destroy
end
