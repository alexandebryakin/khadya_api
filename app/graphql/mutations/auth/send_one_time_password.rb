# frozen_string_literal: true

module Mutations
  module Auth
    class SendOneTimePassword < BaseMutation
      ERROR_ALREADY_SENT = 'already sent'

      argument :code, String, required: true
      argument :number, String, required: true

      def resolve(code:, number:)
        # TODO: validate phone
        phone = Phone.find_or_initialize_by(code:, number:)
        phone.update!(user: current_user) if phone.new_record?

        return otp_already_sent_failure if OneTimePasswords::IsAlreadySent.new(phone:).call

        OneTimePasswords::Send.new(phone:).call

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
