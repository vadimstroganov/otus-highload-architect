# frozen_string_literal: true

class Feed::FetchAction < ApplicationAction
  integer :user_id
  boolean :force, default: false

  validates :user_id, presence: true

  def execute
    Rails.cache.fetch(cache_key, force:) do
      fetch_data_from_database
    end
  end

  private

  def cache_key
    "/users/#{user_id}/feed"
  end

  def fetch_data_from_database
    Post.select_all(:posts)
        .join_table(:inner, :user_friends, [[:friend_id, :user_id], [:user_id, user_id]])
        .order(Sequel[:posts][:created_at].desc)
        .limit(1000)
        .all
  end
end
