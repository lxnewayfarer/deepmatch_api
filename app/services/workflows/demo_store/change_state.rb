# frozen_string_literal: true

module Workflows
  module DemoStore
    class ChangeState < ApplicationService
      STATES = %w[initial started store_form_filled store].freeze

      def call(user:, state:)
        raise Errors::UnknownStateError unless state.in?(::Workflows::DemoStore::Config::STATE_ACTIONS.keys)

        user.update!(state:)
      end
    end
  end
end
