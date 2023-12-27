# frozen_string_literal: true

Sequel.migration do
  change do
    add_index :access_tokens, :value, unique: true
  end
end
