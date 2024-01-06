# frozen_string_literal: true

class Post::DestroyAction < ApplicationAction
  integer :user_id
  integer :post_id

  validates :user_id, :post_id, presence: true

  def execute
    post = Post.where(id: post_id, user_id:)
    return errors.add(:post_id, :not_found) unless post.present?

    post.destroy

    Feed::BuildCacheJob.perform_later(user_id)
  end
end
