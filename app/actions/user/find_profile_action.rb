# frozen_string_literal: true

class User::FindProfileAction < ApplicationAction
  integer :id

  validates :id, presence: true

  def execute
    user = User.first(id: id)
    return errors.add(:id, :not_found) unless user.present?

    user
  end
end
