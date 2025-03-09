# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'API::V1::TelegramWebhooks', type: :request do
  let!(:tenant) { create(:tenant) }
  let!(:bot) { create(:bot, tenant:) }

  path '/api/v1/telegram_webhooks/{id}' do
    let(:id) { bot.id }

    post 'Creates a telegram webhook' do
      tags 'TelegramWebhooks'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body

      response '200', 'webhook created' do
        let(:params) do
          {
            message: {
              text: 'Hello, World!',
              chat: {
                id: 123_456_789
              }
            }
          }
        end

        before do
          allow(::TelegramWebhooksJob).to receive(:perform_async).with(params.to_json)
        end

        run_test! do
          expect(::TelegramWebhooksJob).to have_received(:perform_async).with(params.to_json)
        end
      end
    end
  end
end
