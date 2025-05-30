# frozen_string_literal: true

class Bot < ApplicationRecord
  extend Enumerize

  has_many :users, dependent: :destroy
  has_many :ai_contexts, dependent: :destroy

  enumerize :ai_provider, in: %w[demo deepseek yandex]

  def display_name
    telegram_name
  end

  def webhook_url
    "#{ENV['BACKEND_URL']}/api/v1/telegram_webhooks/#{id}"
  end
end
