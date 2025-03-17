# frozen_string_literal: true

module API
  class APIController < ActionController::API
    def success
      render json: { result: 'success' }
    end

    def created
      render json: { result: 'success' }, status: :created
    end
  end
end
