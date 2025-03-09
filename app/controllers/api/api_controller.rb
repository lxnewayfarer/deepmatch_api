# frozen_string_literal: true

module API
  class APIController < ActionController::API
    def success
      render json: { result: 'success' }
    end
  end
end
