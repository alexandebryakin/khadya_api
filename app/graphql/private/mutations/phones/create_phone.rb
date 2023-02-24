# frozen_string_literal: true

module Private
  module Mutations
    module Phones
      class CreatePhone < BaseMutation
        argument :number, String, required: true

        field :status, ::Types::StatusType
        field :errors, GraphQL::Types::JSON
        field :phone, Types::PhoneType, null: true

        def resolve(number:)
          # TODO: add country code
          phone = current_user.phones.new(number: unformat(number))

          if phone.valid? && phone.save
            { status: status_success, errors: {}, phone: }
          else
            { status: status_failure, errors: phone.errors.messages, phone: nil }
          end
        end

        private

        def unformat(phone)
          # '+7(123) 123-45-67' => '71231234567'
          (phone.presence || '').scan(/\d/).join('')
        end
      end
    end
  end
end
