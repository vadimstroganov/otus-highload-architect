# frozen_string_literal: true

module User
  class FindProfileAction < ApplicationAction
    integer :id

    validates :id, presence: true

    def execute
      sql = <<~SQL.squish
        SELECT
          id, first_name, second_name, birthdate, city, biography
        FROM
          users
        WHERE
          id = ?
        LIMIT 1;
      SQL

      user = DB[sql, id].first
      return errors.add(:id, :not_found) unless user.present?

      user
    end
  end
end
