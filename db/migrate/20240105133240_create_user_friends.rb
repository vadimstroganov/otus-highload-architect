# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :user_friends do
      primary_key :id
      column :user_id, :Bignum, null: false
      column :friend_id, :Bignum, null: false
      column :created_at, :Timestamp, null: false, default: Sequel.lit('now()')
      column :updated_at, :Timestamp, null: false, default: Sequel.lit('now()')
    end

    add_index :user_friends, %i[user_id friend_id], unique: true
  end
end
