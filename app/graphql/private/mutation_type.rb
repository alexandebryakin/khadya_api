# frozen_string_literal: true

module Private
  class MutationType < ::Types::BaseObject
    field :change_current_user_password, mutation: Mutations::Users::ChangeCurrentUserPassword

    field :create_phone, mutation: Mutations::Phones::CreatePhone
    field :create_email, mutation: Mutations::Emails::CreateEmail
  end
end
