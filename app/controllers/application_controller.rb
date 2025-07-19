# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def not_found
    render json: { "success": false, "error": 'Not found' }, status: :not_found
  end

  def forbidden
    render json: { "success": false, "error": 'Forbidden' }, status: :forbidden
  end

  def created
    render json: { "success": true }, status: :created
  end

  def success
    render json: { "success": true }, status: :ok
  end
end
