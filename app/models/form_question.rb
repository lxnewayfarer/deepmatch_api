# frozen_string_literal: true

class FormQuestion < ApplicationRecord
  extend Enumerize

  belongs_to :form
  has_many :form_answers, dependent: :destroy

  enumerize :kind, in: {
    string: 'Text',
    size: 'Size',
    sex: 'Sex',
    phone: 'Phone',
    integer: 'Number'
  }

  enumerize :slug, in: %w[name size shoe_size phone sex]
end
