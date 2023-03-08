# frozen_string_literal: true

module Users
  class GenerateAnonymousUser
    def call
      User.create!(
        kind: 'anonymous',
        password: User::ANONYMOUS_USER_PASSWORD
      )
      # TODO: add roles for anonymous user
    end
  end
end
