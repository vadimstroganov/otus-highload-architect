# frozen_string_literal: true

module Api
  module V1
    class FriendsController < Api::BaseController
      before_action :auth!

      def create
        outcome = UserFriend::CreateAction.run(unsafe_params)
        return render_error(outcome.errors.details) unless outcome.valid?

        render_success(outcome.result)
      end

      def destroy
        outcome = UserFriend::DestroyAction.run(unsafe_params.merge(friend_id: params[:id]))
        return render_error(outcome.errors.details) unless outcome.valid?

        render_success(outcome.result)
      end
    end
  end
end
