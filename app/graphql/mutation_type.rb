# frozen_string_literal: true

class MutationType < ::Types::BaseObject
  field :signup_user, mutation: Mutations::Auth::SignupUser
  field :signin_user, mutation: Mutations::Auth::SigninUser
  field :send_one_time_password, mutation: Mutations::Auth::SendOneTimePassword
  field :verify_one_time_password, mutation: Mutations::Auth::VerifyOneTimePassword

  field :change_current_user_password, mutation: Mutations::Users::ChangeCurrentUserPassword

  field :create_phone, mutation: Mutations::Phones::CreatePhone

  field :create_email, mutation: Mutations::Emails::CreateEmail
end
