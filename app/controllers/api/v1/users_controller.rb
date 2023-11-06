# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::BaseController
      def login
        outcome = User::LoginAction.run(unsafe_params)
        return render_error(outcome.errors.details) unless outcome.valid?

        render_success({ token: outcome.result })
      end

      def show
        outcome = User::FindProfileAction.run(unsafe_params)
        return render_error(outcome.errors.details) unless outcome.valid?

        render_success(UserSerializer.render_as_hash(outcome.result))
      end

      def create
        outcome = User::CreateProfileAction.run(unsafe_params)
        return render_error(outcome.errors.details) unless outcome.valid?

        render_success({ id: outcome.result })
      end
    end
  end
end
