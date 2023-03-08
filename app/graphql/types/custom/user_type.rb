# frozen_string_literal: true

module Types
  module Custom
    class UserType < ::Types::BaseObject
      graphql_name 'User'

      class UserKindEnum < ::Types::BaseEnum
        graphql_name 'UserKind'

        ::User.kinds.each_key do |kind|
          value kind
        end
      end

      field :id, ID, null: false
      field :first_name, String, null: true
      field :last_name, String, null: true
      field :language_code, String, null: false
      field :kind, UserKindEnum, null: false
      field :phones, [Types::Custom::PhoneType], null: false
      field :emails, [Types::Custom::EmailType], null: false
    end
  end
end
