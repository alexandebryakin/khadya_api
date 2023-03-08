# frozen_string_literal: true

module OneTimePasswords
  class Send
    extend Dry::Initializer

    option :phone

    def call
      # TODO: send OTP
      OneTimePassword.create!(phone:, otp: generate_six_digit_otp)

      true
    end

    private

    def generate_six_digit_otp
      (rand.ceil(6) * 1_000_000).to_i
    end
  end
end
