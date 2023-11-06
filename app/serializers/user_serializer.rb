# frozen_string_literal: true

class UserSerializer < Blueprinter::Base
  identifier :id
  fields :first_name, :second_name, :birthdate, :city, :biography
end
