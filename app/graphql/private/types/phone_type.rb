# frozen_string_literal: true

module Private
  module Types
    class PhoneType < ::Types::BaseObject
      field :id, ID, null: false
      field :number, String, null: false
      field :is_primary, Boolean, null: false
      field :verification_status, Types::VerificationStatusEnum, null: false
    end
  end
end
