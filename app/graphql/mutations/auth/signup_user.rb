# frozen_string_literal: true

module Mutations
  module Auth
    class SignupUser < BaseMutation
      argument :email, String, required: true # TODO: change
      argument :password, String, required: true

      field :token, String, null: true
      field :user, Types::Custom::UserType, null: true

      def resolve(email:, password:)
        user = User.create(password:, emails_attributes: [{ email:, is_primary: true }])

        if user.valid?
          success(user:, token: ::Auth::GenerateJwt.new(user:).call)
        else
          failure(user: nil, token: nil, errors: transform_error_messages(user.errors.messages))
        end
      end

      private

      def transform_error_messages(messages)
        messages.transform_keys { _1.to_s == 'emails.email' ? 'email' : _1 }
      end
    end
  end
end
