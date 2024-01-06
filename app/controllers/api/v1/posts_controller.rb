# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::BaseController
      before_action :auth!

      def create
        outcome = Post::CreateAction.run(unsafe_params.merge(user_id: current_user.id))
        return render_error(outcome.errors.details) unless outcome.valid?

        render_success(outcome.result)
      end

      def destroy
        outcome = Post::DestroyAction.run(unsafe_params.merge(user_id: current_user.id, post_id: unsafe_params[:id]))
        return render_error(outcome.errors.details) unless outcome.valid?

        render_success({})
      end
    end
  end
end
