# frozen_string_literal: true

class Network < ApplicationRecord
  belongs_to :user
  has_many :restaurants, dependent: :destroy
end
