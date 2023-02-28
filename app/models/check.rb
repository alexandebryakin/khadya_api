# frozen_string_literal: true

class Check < ApplicationRecord
  has_many :orders, dependent: :destroy
end
