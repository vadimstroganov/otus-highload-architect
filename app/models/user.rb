# frozen_string_literal: true

class User < Sequel::Model
  one_to_many :access_tokens
end
