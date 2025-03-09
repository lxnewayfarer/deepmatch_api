# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendMessageJob, type: :job do
  describe '#perform' do
    let(:token) { 'fake_token' }
    let(:messages) { [{ chat_id: 123, text: 'Hello' }].to_json }
    let(:telegram_api_instance) { instance_double(TelegramAPI) }

    before do
      allow(TelegramAPI).to receive(:new).with(token).and_return(telegram_api_instance)
      allow(telegram_api_instance).to receive(:send_messages)
    end

    it 'calls TelegramAPI with the correct arguments' do
      described_class.new.perform(token, messages)

      expect(TelegramAPI).to have_received(:new).with(token)
      expect(telegram_api_instance).to have_received(:send_messages).with(JSON.parse(messages))
    end
  end
end
