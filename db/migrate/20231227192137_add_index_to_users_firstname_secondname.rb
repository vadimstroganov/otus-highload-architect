# frozen_string_literal: true

Sequel.migration do
  up do
    execute 'create index users_first_name_second_name_index on users using gin(first_name gin_trgm_ops, second_name gin_trgm_ops);'
  end

  down do
    execute 'drop index users_first_name_second_name_index;'
  end
end

