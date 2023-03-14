# frozen_string_literal: true

module Auth
  class IdentifyCurrentUser
    extend Dry::Initializer

    option :authorization_header

    def call
      decoded = Auth::JwtDecode.new.call(token:)

      User.find(decoded['data']['user']['id']).tap do |user|
        user.touch(:last_visited_at)
      end
    rescue JWT::DecodeError => e
      # TODO: handle
      raise e
    end

    private

    def token
      @token ||= (authorization_header.presence || '').split(' ').last
    end
  end
end
