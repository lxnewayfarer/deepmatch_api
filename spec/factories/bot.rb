# frozen_string_literal: true

FactoryBot.define do
  factory :bot do
    telegram_name { 'some_bot' }
    config_slug { 'demo_store' }
    token { 'abcd111' }
  end
end
