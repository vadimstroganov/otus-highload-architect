# frozen_string_literal: true

class User::SearchAction < ApplicationAction
  string :first_name
  string :second_name

  validates :first_name, :second_name, presence: true

  def execute
    User.where(Sequel.like(:first_name, "%#{first_name}%"))
        .where(Sequel.like(:second_name, "%#{second_name}%"))
        .server(:replica1)
        .all
  end
end
