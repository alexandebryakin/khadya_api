# frozen_string_literal: true

module Private
  module Queries
    module Users
      class GetUser < ::BaseResolver
        argument :user_id, ID, required: true

        type Types::UserType, null: true

        def resolve(user_id:)
          User.find_by(id: user_id)
        end
      end
    end
  end
end
