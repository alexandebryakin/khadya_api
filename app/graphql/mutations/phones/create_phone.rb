# frozen_string_literal: true

module Mutations
  module Phones
    class CreatePhone < BaseMutation
      argument :number, String, required: true

      field :phone, Types::Custom::PhoneType, null: true

      def resolve(number:)
        # TODO: add country code
        phone = current_user.phones.new(number: unformat(number))

        if phone.valid? && phone.save
          success(phone:)
        else
          failure(errors: phone.errors.messages, phone: nil)
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
