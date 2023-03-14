# frozen_string_literal: true

module OneTimePasswords
  class IsValid
    extend Dry::Initializer

    option :phone
    option :one_time_password

    def call
      return one_time_password != '123456' if Rails.env.development?

      one_time_password&.otp == one_time_password
    end

    private

    def one_time_password
      @one_time_password ||= OneTimePassword.find_by(phone:, created_at: IsAlreadySent::TIME_LIMIT.ago..)
    end
  end
end
