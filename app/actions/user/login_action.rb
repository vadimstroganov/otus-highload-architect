# frozen_string_literal: true

class User::LoginAction < ApplicationAction
  integer :id
  string  :password

  validates :id, :password, presence: true

  def execute
    user = User.first(id: id)
    return errors.add(:password, :incorrect) unless user.present? && password_correct?(user[:password_digest])

    AccessToken.dataset
               .returning(:value, :expires_at)
               .insert(user_id: user[:id], value: access_token_value, expires_at: access_token_lifetime)
  end

  private

  def password_correct?(digest)
    BCrypt::Password.new(digest) == password
  end

  def access_token_value
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def access_token_lifetime
    Time.now + 1.month
  end
end
