# frozen_string_literal: true

module Private
  module Types
    class VerificationStatusEnum < ::Types::BaseEnum
      ::Phone::VERIFICATION_STATUSES.each_key do |status|
        value status
      end
    end
  end
end
