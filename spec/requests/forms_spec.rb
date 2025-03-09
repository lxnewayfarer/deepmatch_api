# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe FormsController, type: :request do
  let!(:tenant) { create(:tenant) }
  let!(:bot) { create(:bot, tenant:) }
  let!(:user) { create(:user, bot:) }
  let!(:form) { create(:form, bot:) }
  let!(:form_question) { create(:form_question, form:) }
  let!(:message_template) { create(:message_template, bot:) }

  before { user.start! }

  path '/forms/{id}' do
    get 'Retrieves a form' do
      tags 'Forms'
      produces 'http/text'
      parameter name: :id, in: :path, type: :string

      let(:id) { form.id }

      response '200', 'form found' do
        run_test!
      end
    end
  end

  path '/forms' do
    post 'Creates a form confirmation' do
      tags 'Forms'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object
      }

      response '200', 'form confirmation created' do
        let(:params) do
          {
            id: form.id,
            user_telegram_id: user.telegram_id,
            form: {
              username: 'johndoe',
              first_name: 'John',
              last_name: 'Doe',
              form_answers_attributes: [
                { form_question_id: form_question.id, answer: 'Yes' }
              ]
            }
          }
        end

        run_test!
      end
    end
  end
end
