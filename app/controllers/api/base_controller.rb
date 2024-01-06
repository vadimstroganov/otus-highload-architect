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
      params.to_unsafe_h.merge \
        current_user: current_user,
        remote_ip: request.remote_ip
    end

    def raw_token
      @raw_token ||= request.headers['Authorization']
    end

    def current_user
      @current_user ||= AccessToken::FindUserAction.run(value: raw_token).result
    end

    def auth!
      return render_error({ authorization: [{ error: 'empty' }] }, status: :unauthorized) unless raw_token.present?
      return if current_user.present?

      render_error({ authorization: [{ error: 'invalid', value: raw_token }] }, status: :unauthorized)
    end
  end
end
