# frozen_string_literal: true

module Private
  module Types
    class UserType < ::Types::BaseObject
      field :id, ID, null: false
      field :phones, [Types::PhoneType], null: false
      field :emails, [Types::EmailType], null: false
    end
  end
end
