# frozen_string_literal: true

class UserFriend::DestroyAction < ApplicationAction
  object  :current_user, class: User
  integer :friend_id

  validates :friend_id, :current_user, presence: true

  def execute
    deleted_row = \
      UserFriend.dataset
                .returning(:friend_id)
                .where(user_id: current_user.id, friend_id: friend_id)
                .delete

    return errors.add(:friend_id, :not_found) unless deleted_row.present?

    deleted_row.first
  end
end
