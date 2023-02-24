# frozen_string_literal: true

module Public
  class MutationType < ::Types::BaseObject
    field :signup_user, mutation: Mutations::Auth::SignupUser
    field :signin_user, mutation: Mutations::Auth::SigninUser
  end
end
