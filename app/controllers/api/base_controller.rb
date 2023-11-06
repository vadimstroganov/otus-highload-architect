# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    private

    def render_success(json, status: :ok)
      render json: { data: json }, status:
    end

    def render_error(json, status: :bad_request)
      render json: { errors: json }, status:
    end

    def unsafe_params
      params.to_unsafe_h
    end
  end
end
