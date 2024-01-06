# frozen_string_literal: true

class Post < Sequel::Model
  many_to_one :user

  def before_create # or after_initialize
    super
    self.text ||= 'Thing'
  end
end
