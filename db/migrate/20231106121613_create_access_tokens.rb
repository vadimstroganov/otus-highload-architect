# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :access_tokens do
      primary_key :id, type: :Bignum
      column :user_id, :Bignum, null: false
      column :value, String, null: false
      column :expires_at, :Timestamp, null: false
      column :created_at, :Timestamp, null: false, default: Sequel.lit("now()")
      column :updated_at, :Timestamp, null: false, default: Sequel.lit("now()")
    end
  end
end
