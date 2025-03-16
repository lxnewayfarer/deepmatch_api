# frozen_string_literal: true

class User < ApplicationRecord
  include AASM

  belongs_to :bot
  has_many :messages, dependent: :destroy
  has_many :form_answers, dependent: :destroy

  aasm do
    state :initial, initial: true
    state :started, :form_filled

    event :start do
      transitions from: :initial, to: :started
    end

    event :confirm_form do
      transitions from: :started, to: :form_filled
    end
  end
end
