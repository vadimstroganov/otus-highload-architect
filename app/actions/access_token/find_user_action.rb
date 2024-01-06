# frozen_string_literal: true

class AccessToken::FindUserAction < ApplicationAction
  string :value

  validates :value, presence: true

  def execute
    token = AccessToken.where(expires_at: Time.now.utc..).where(value:).first
    token&.user
  end
end
