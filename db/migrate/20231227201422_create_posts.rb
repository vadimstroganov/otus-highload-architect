# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :posts do
      primary_key :id
      column :user_id, :Bignum, null: false
      column :text, String
      column :created_at, :Timestamp, null: false, default: Sequel.lit('now()')
      column :updated_at, :Timestamp, null: false, default: Sequel.lit('now()')
    end

    add_index :posts, :user_id
    add_index :posts, :created_at
  end
end
