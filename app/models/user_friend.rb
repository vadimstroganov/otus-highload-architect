# frozen_string_literal: true

class UserFriend < Sequel::Model
  many_to_one :user
end
