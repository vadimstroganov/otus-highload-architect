# frozen_string_literal: true

class AccessToken < Sequel::Model
  many_to_one :user
end
