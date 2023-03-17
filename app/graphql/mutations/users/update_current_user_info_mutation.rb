# frozen_string_literal: true

module Mutations
  module Users
    class UpdateCurrentUserInfoMutation < BaseMutation
      argument :first_name, String, required: true
      argument :last_name, String, required: false

      field :user, Types::Custom::UserType, null: false

      def resolve(first_name:, last_name:)
        if current_user.update(first_name:, last_name:)
          success(user: current_user)
        else
          failure(user: current_user, errors: current_user.errors.messages)
        end
      end
    end
  end
end
