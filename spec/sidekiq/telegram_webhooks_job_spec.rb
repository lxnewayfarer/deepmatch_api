# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TelegramWebhooksJob, type: :job do
  describe '#perform' do
    let(:data) { { 'message' => { 'text' => 'Hello', 'chat' => { 'id' => 123 } } }.to_json }
    let(:parsed_data) { JSON.parse(data) }

    before do
      allow(TelegramBots::HandleMessage).to receive(:call)
    end

    it 'calls TelegramBots::HandleMessage with the correct arguments' do
      described_class.new.perform(data)

      expect(TelegramBots::HandleMessage).to have_received(:call).with(parsed_data)
    end
  end
end
