# frozen_string_literal: true

module Mutations
  module Auth
    class SigninUser < BaseMutation
      CANT_BE_BLANK = "can't be blank"
      NOT_FOUND = 'not found'
      INVALID_CREDENTIALS = 'invalid credentials'

      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :user, Types::Custom::UserType, null: true

      def resolve(email:, password:)
        return wrap_response(empty_credentials_errors) if empty_credentials_errors.present?

        user = User.joins(:emails).find_by(emails: { email: })

        return wrap_response(user: [NOT_FOUND]) if user.blank?
        return wrap_response(user: [INVALID_CREDENTIALS]) unless user.authenticate(password)

        token = ::Auth::GenerateJwt.new(user:).call

        success(token:, user:)
      end

      private

      def wrap_response(errors)
        failure(token: nil, user: nil, errors:)
      end

      def empty_credentials_errors
        @empty_credentials_errors ||= {}.tap do |errors|
          errors[:email] = [CANT_BE_BLANK] if arguments[:email].blank?
          errors[:password] = [CANT_BE_BLANK] if arguments[:password].blank?
        end
      end
    end
  end
end
