# frozen_string_literal: true

module Types
  module Custom
    class VerificationStatusEnum < ::Types::BaseEnum
      ::Phone.verification_statuses.each_key do |status|
        value status
      end
    end
  end
end
