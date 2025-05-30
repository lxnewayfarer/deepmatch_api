# frozen_string_literal: true

module StateCommands
  class ChangeState < ApplicationService
    def call(user:, state:)
      raise Errors::UnknownStateError unless state.in?(StatesConfig::STATE_ACTIONS.keys)

      user.update!(state:)
    end
  end
end
