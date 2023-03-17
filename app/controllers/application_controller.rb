# frozen_string_literal: true

class ApplicationController < ActionController::API
  def current_user
    @current_user ||= Auth::IdentifyCurrentUser.new(authorization_header: request.headers['Authorization']).call
  end

  def current_token
    (request.headers['Authorization'].presence || '').split(' ').last
  end
end
