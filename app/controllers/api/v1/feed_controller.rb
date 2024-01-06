# frozen_string_literal: true

module Api
  module V1
    class FeedController < Api::BaseController
      before_action :auth!

      def index
        outcome = Feed::FetchAction.run(user_id: current_user.id)
        return render_error(outcome.errors.details) unless outcome.valid?

        render_success(PostSerializer.render_as_hash(outcome.result))
      end
    end
  end
end
