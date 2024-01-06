# frozen_string_literal: true

class Post::CreateAction < ApplicationAction
  integer :user_id
  string :text

  validates :user_id, :text, presence: true

  def execute
    post = \
      Post.dataset
          .returning(:id)
          .insert(user_id:, text:)
          .first

    Feed::BuildCacheJob.perform_later(user_id)

    post
  end
end
