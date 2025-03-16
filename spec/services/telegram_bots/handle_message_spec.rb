# frozen_string_literal: true

# spec/services/telegram_bots/handle_message_spec.rb

require 'rails_helper'

RSpec.describe TelegramBots::HandleMessage, type: :service do
  let(:tenant) { create(:tenant) }
  let(:bot) { create(:bot, tenant:) }

  describe '#call' do
    let(:params) do
      {
        bot_id: bot.id,
        message: {
          text: 'Hello, world!',
          from: { id: 123, username: 'test_user' }
        }
      }.with_indifferent_access
    end

    before do
      allow(Workflows::DemoStore::HandleMessage).to receive(:call).and_return(true)
    end

    context 'when bot is found and service exists' do
      it 'calls the correct workflow service' do
        described_class.call(params)

        expect(Workflows::DemoStore::HandleMessage).to have_received(:call).with(params)
      end
    end
  end
end
