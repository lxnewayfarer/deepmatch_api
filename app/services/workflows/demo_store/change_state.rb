# frozen_string_literal: true

module Workflows
  module DemoStore
    class ChangeState < ApplicationService
      STATES = %w[initial started form_filled store].freeze

      def call(user:, state:)
        raise Errors::UnknownStateError unless state.in?(STATES)

        user.update!(state:)
      end
    end
  end
end
