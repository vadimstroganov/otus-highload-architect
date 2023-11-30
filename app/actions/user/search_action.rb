# frozen_string_literal: true

module User
  class SearchAction < ApplicationAction
    string :first_name
    string :second_name

    validates :first_name, :second_name, presence: true

    def execute
      sql = <<~SQL.squish
        SELECT
          id, first_name, second_name, birthdate, biography, city
        FROM
          users
        WHERE
          first_name LIKE ? AND second_name LIKE ?
      SQL

      DB[sql, "%#{first_name}%", "%#{second_name}%"].all
    end
  end
end
