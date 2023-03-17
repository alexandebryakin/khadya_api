# frozen_string_literal: true

module OneTimePasswords
  class IsValid
    extend Dry::Initializer

    option :phone
    option :one_time_password

    def call
      one_time_password_record.update!(is_confirmed: true) if otp_matches?

      otp_matches?
    end

    private

    def one_time_password_record
      @one_time_password_record ||= OneTimePassword.find_by(
        phone:,
        created_at: IsAlreadySent::TIME_LIMIT.ago..,
        is_confirmed: false,
        otp: one_time_password
      )
    end

    def otp_matches?
      one_time_password_record.present?
    end
  end
end
