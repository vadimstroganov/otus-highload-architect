# frozen_string_literal: true

class PostSerializer < Blueprinter::Base
  identifier :id
  fields :text
  field :user_id, name: :author_user_id
end
