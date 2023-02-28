# frozen_string_literal: true

class Meal < ApplicationRecord
  belongs_to :menu
  has_many :meal_setups, dependent: :destroy
  has_one :eating_guideline, dependent: :destroy
end
