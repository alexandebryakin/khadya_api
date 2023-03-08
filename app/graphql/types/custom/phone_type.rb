# frozen_string_literal: true

module Types
  module Custom
    class PhoneType < ::Types::BaseObject
      field :id, ID, null: false
      field :code, String, null: false
      field :number, String, null: false
      field :is_primary, Boolean, null: false
      field :verification_status, Types::Custom::VerificationStatusEnum, null: false
    end
  end
end
