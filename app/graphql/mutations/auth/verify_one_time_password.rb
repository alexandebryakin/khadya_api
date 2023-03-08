# frozen_string_literal: true

module Mutations
  module Auth
    class VerifyOneTimePassword < BaseMutation
      ERROR_OTP_INVALID = 'OTP invalid'

      argument :one_time_password, String, required: true
      argument :code, String, required: true
      argument :number, String, required: true

      field :user, Types::Custom::UserType, null: false

      def resolve(one_time_password:, code:, number:)
        phone = current_user.phones.find_by(code:, number:)

        return otp_invalid_failure if invalid_otp?(phone:, one_time_password:)

        Users::ConvertAnonymousToReal.new(user: current_user).call

        success(user: current_user.reload)
      end

      private

      def otp_invalid_failure
        failure(errors: {
          one_time_password: [ERROR_OTP_INVALID]
        })
      end

      def invalid_otp?(phone:, one_time_password:)
        !OneTimePasswords::IsValid.new(phone:, one_time_password:).call
      end
    end
  end
end
