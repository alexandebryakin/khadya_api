# frozen_string_literal: true

module Auth
  class GenerateJwt
    extend Dry::Initializer

    option :user

    def call
      JwtEncode.new.call(
        data: {
          user: {
            id: user.id
          }
        }
      )
    end
  end
end