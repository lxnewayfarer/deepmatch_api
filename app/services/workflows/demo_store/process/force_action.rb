# frozen_string_literal: true

module Workflows
  module DemoStore
    module Process
      class ForceAction < WorkflowService
        attr_reader :user

        def call(user)
          if user.state == 'store'
            ::Workflows::DemoStore::Process::AskForm.call(user)
            return true
          end

          false
        end
      end
    end
  end
end
