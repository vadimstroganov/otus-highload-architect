# frozen_string_literal: true

class UserFriend::CreateAction < ApplicationAction
  object  :current_user, class: User
  integer :friend_id

  validates :friend_id, :current_user, presence: true

  def execute
    UserFriend.dataset
              .returning(:friend_id)
              .insert(user_id: current_user.id, friend_id: friend_id)
  rescue Sequel::UniqueConstraintViolation
    errors.add(:friend_id, :taken)
  end
end
