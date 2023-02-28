# frozen_string_literal: true

class RestaurantsEmployee < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
end
