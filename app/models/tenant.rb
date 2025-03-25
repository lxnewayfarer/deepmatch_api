# frozen_string_literal: true

class Tenant < ApplicationRecord
  extend Enumerize

  has_many :bots, dependent: :destroy

  enumerize :ai_provider, in: %w[demo deepseek yandex]
end
