# frozen_string_literal: true

class Feed::BuildCacheJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    UserFriend.where(friend_id: user_id).each do |row|
      Feed::FetchAction.run(user_id: row.user_id, force: true)
    end
  end
end
