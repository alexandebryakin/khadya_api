# frozen_string_literal: true

module Private
  module Mutations
    module Emails
      class CreateEmail < BaseMutation
        argument :email, String, required: true

        field :status, ::Types::StatusType
        field :errors, GraphQL::Types::JSON
        field :email, Types::EmailType, null: true

        def resolve(email:)
          email = current_user.emails.new(email:)

          if email.save
            { status: status_success, errors: {}, email: }
          else
            { status: status_failure, errors: email.errors.messages, email: nil }
          end
        end
      end
    end
  end
end
