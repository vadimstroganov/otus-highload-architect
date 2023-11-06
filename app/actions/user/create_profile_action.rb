# frozen_string_literal: true

module User
  class User::CreateProfileAction < ApplicationAction
    string :first_name
    string :second_name
    date   :birthdate
    string :city
    string :biography, default: nil
    string :password

    validates :first_name, :second_name, :birthdate, :city, presence: true
    validates :password, presence: true, length: { minimum: 6 }

    def execute
      sql = <<~SQL.squish
        INSERT INTO users (first_name, second_name, birthdate, city, biography, password_digest)
        VALUES (?, ?, ?, ?, ?, ?)
        RETURNING id;
      SQL

      DB[sql, first_name, second_name, birthdate, city, biography.presence, password_digest].first[:id]
    end

    private

    def password_digest
      BCrypt::Password.create(password)
    end
  end
end
