# frozen_string_literal: true

module OneTimePasswords
  class IsAlreadySent
    TIME_LIMIT = 30.seconds

    extend Dry::Initializer

    option :phone

    def call
      OneTimePassword.where(phone:, created_at: TIME_LIMIT.ago.., is_confirmed: false).exists?
    end
  end
end
