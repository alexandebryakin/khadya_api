# frozen_string_literal: true

class MealSetup < ApplicationRecord
  belongs_to :meal
  has_many :meal_setups_ingredients, dependent: :destroy
  has_many :ingredients, through: :meal_setups_ingredients
end
