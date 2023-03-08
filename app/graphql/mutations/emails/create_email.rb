# frozen_string_literal: true

module Mutations
  module Emails
    class CreateEmail < BaseMutation
      argument :email, String, required: true

      field :email, Types::Custom::EmailType, null: true

      def resolve(email:)
        email = current_user.emails.new(email:)

        if email.save
          success(email:)
        else
          failure(errors: email.errors.messages, email: nil)
        end
      end
    end
  end
end
