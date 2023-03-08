# frozen_string_literal: true

module OneTimePasswords
  class IsAlreadySent
    TIME_LIMIT = 5.minutes

    extend Dry::Initializer

    option :phone

    def call
      OneTimePassword.where(phone:, created_at: TIME_LIMIT.ago..).exists?
    end
  end
end
