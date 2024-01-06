# frozen_string_literal: true

class User < Sequel::Model
  one_to_many :access_tokens
  one_to_many :posts
  one_to_many :user_friends
end
