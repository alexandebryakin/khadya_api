# frozen_string_literal: true

module PublicApi
  class BaseController < ApplicationController
    def current_user
      @current_user ||= nil # TODO: maybe User.new ?
    end
  end
end
