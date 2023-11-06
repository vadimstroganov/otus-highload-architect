# frozen_string_literal: true

module User
  class LoginAction < ApplicationAction
    integer :id
    string  :password

    validates :id, :password, presence: true

    def execute
      find_user_sql = <<~SQL.squish
        SELECT
          id, password_digest
        FROM
          users
        WHERE
          id = ?
        LIMIT 1;
      SQL

      create_access_token_sql = <<~SQL.squish
        INSERT INTO access_tokens (user_id, value, expires_at)
        VALUES (?, ?, ?)
        RETURNING value, expires_at;
      SQL

      user = DB[find_user_sql, id].first
      return errors.add(:password, :incorrect) unless user.present? && password_correct?(user[:password_digest])

      # TODO: Add a unique index on a value in the database
      DB[create_access_token_sql, user[:id], access_token_value, access_token_lifetime].first
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
end
