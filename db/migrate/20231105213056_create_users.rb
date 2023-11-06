# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :users do
      primary_key :id, type: :Bignum
      column :first_name, String, null: false
      column :second_name, String, null: false
      column :birthdate, Date, null: false
      column :biography, String
      column :city, String, null: false
      column :password_digest, String
      column :created_at, :Timestamp, null: false, default: Sequel.lit("now()")
      column :updated_at, :Timestamp, null: false, default: Sequel.lit("now()")
    end
  end
end
