# frozen_string_literal: true

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
    User.dataset
        .returning(:id)
        .insert(first_name:, second_name:, birthdate:, city:, password_digest:, biography: biography.presence)
        .first[:id]
  end

  private

  def password_digest
    BCrypt::Password.create(password)
  end
end
