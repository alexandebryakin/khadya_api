# frozen_string_literal: true

module PrivateApi
  class BaseController < ApplicationController
    def current_user
      # https://www.howtographql.com/graphql-ruby/4-authentication/

      @current_user ||= begin
        token = (request.headers['Authorization'].presence || '').split(' ').last
        decoded = Auth::JwtDecode.new.call(token:)

        User.find(decoded['data']['user']['id'])
      rescue JWT::DecodeError => e
        # TODO: handle
        raise e
      end
    end
  end
end
