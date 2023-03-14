# frozen_string_literal: true

module Mutations
  module Auth
    class VerifyOneTimePassword < BaseMutation
      ERROR_OTP_INVALID = 'OTP invalid'

      argument :one_time_password, String, required: true
      argument :code, String, required: true
      argument :number, String, required: true

      class Errors < ::Types::BaseObject
        field :one_time_password, [String], null: true
      end

      field :errors, Errors, null: false
      field :user, Types::Custom::UserType, null: false

      def resolve(one_time_password:, code:, number:)
        phone = Phone.find_by(code:, number:)
        user = phone.user

        return otp_invalid_failure(user:) if invalid_otp?(phone:, one_time_password:)

        phone.update!(verification_status: 'succeeded', is_primary: true)
        ::Users::ConvertAnonymousToReal.new(user:).call

        success(user: user.reload)
      end

      private

      def otp_invalid_failure(user:)
        failure(
          user:,
          errors: {
            one_time_password: [ERROR_OTP_INVALID]
          }
        )
      end

      def invalid_otp?(phone:, one_time_password:)
        !OneTimePasswords::IsValid.new(phone:, one_time_password:).call
      end
    end
  end
end
