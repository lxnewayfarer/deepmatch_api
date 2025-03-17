# frozen_string_literal: true

module API
  module V1
    class DemoRequestsController < ::API::APIController
      def create
        ::DemoRequests::CreateDemoRequest.call(create_params)

        created
      end

      private

      def create_params
        params.permit(:name, :contact, :company)
      end
    end
  end
end
