# frozen_string_literal: true

class Tenant < ApplicationRecord
  has_many :bots, dependent: :destroy

  enumerize :ai_provider, in: %w[demo deepseek]
end
