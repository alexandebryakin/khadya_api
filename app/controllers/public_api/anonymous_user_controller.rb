# frozen_string_literal: true

module PublicApi
  class AnonymousUserController < ActionController::API
    def new
      user = Users::GenerateAnonymousUser.new.call
      token = Auth::GenerateJwt.new(user:).call

      render(json: { token: }, status: :ok)
    end
  end
end
