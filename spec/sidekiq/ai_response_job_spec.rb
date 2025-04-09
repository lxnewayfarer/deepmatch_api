# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AIResponseJob, type: :job do
  subject { described_class.new.perform(bot.id, user.id, input_text, ai_context) }

  let(:tenant) { create(:tenant) }
  let(:bot) { create(:bot, tenant:) }
  let(:user) { create(:user, bot:) }
  let(:input_text) { 'Hello' }
  let(:ai_response) { 'AI generated response' }
  let(:ai_context) { 'AI context' }

  describe '#perform' do
    context 'when AI service responds successfully' do
      before do
        allow(AI::DemoResponse).to receive(:call).and_return(ai_response)
        allow(TelegramBots::SendMessage).to receive(:call)
      end

      it 'calls the correct AI service' do
        subject

        expect(AI::DemoResponse).to have_received(:call).with(input_text, ai_context)
      end

      it 'sends message via TelegramBots::SendMessage' do
        subject

        expect(TelegramBots::SendMessage).to have_received(:call).with(
          bot: bot,
          user: user,
          text: ai_response,
          reply_markup: instance_of(String),
          ai_generated_response: true
        )
      end
    end

    context 'when AI service raises an error' do
      let!(:error_message) { create(:message_template, bot:, slug: 'ai_response_error', text: 'Some text') }

      before do
        allow(AI::DemoResponse).to receive(:call).and_raise(StandardError)
        allow(Rollbar).to receive(:error)
        allow(TelegramBots::SendMessageTemplate).to receive(:call)
      end

      it 'logs error to Rollbar' do
        subject

        expect(Rollbar).to have_received(:error).with(instance_of(StandardError))
      end

      it 'sends error message from template' do
        subject

        expect(TelegramBots::SendMessageTemplate).to have_received(:call).with(
          bot:,
          user:,
          slug: error_message.slug,
          reply_markup: instance_of(String)
        )
      end
    end

    context 'with different AI providers' do
      before do
        allow(AI::DeepseekResponse).to receive(:call)
        allow(AI::DemoResponse).to receive(:call)
      end

      context 'when demo AI provider' do
        it 'uses DemoResponse for demo provider' do
          subject

          expect(AI::DemoResponse).to have_received(:call)
        end
      end

      context 'when deepseek AI provider' do
        before { bot.tenant.update!(ai_provider: 'deepseek') }

        it 'uses DeepseekResponse for deepseek provider' do
          subject

          expect(AI::DeepseekResponse).to have_received(:call)
        end
      end
    end
  end
end
