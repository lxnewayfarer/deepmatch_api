# frozen_string_literal: true

class Bot < ApplicationRecord
  belongs_to :tenant
  has_many :users, dependent: :destroy
  has_many :forms, dependent: :destroy
  has_many :ai_contexts, dependent: :destroy

  def display_name
    telegram_name
  end

  def webhook_url
    "#{ENV['BACKEND_URL']}/api/v1/telegram_webhooks/#{id}"
  end

  def active_form
    forms.last
  end
end
