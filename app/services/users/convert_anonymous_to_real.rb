# frozen_string_literal: true

module Users
  class ConvertAnonymousToReal
    extend Dry::Initializer

    option :user

    def call
      user.kind_real!
      # TODO: add roles
    end
  end
end
