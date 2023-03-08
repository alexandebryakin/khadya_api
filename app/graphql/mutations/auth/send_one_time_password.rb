# frozen_string_literal: true

module Mutations
  module Auth
    class SendOneTimePassword < BaseMutation
      ERROR_ALREADY_SENT = 'already sent'

      argument :code, String, required: true
      argument :number, String, required: true

      def resolve(code:, number:)
        phone = current_user.phones.find_or_create_by!(code:, number:)

        return otp_already_sent_failure if OneTimePasswords::IsAlreadySent.new(phone:).call

        # TODO: validate phone
        OneTimePasswords::Send.new.call(phone:)

        success
      end

      private

      def otp_already_sent_failure
        failure(errors: {
          one_time_password: [ERROR_ALREADY_SENT]
        })
      end
    end
  end
end
