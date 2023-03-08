# frozen_string_literal: true

class MealSetup < ApplicationRecord
  enum :kind, {
    main: 'main',
    size: 'size',
    addition: 'addition'
  }, default: 'main', prefix: true

  belongs_to :meal
  has_many :meal_setups_ingredients, dependent: :destroy
  has_many :ingredients, through: :meal_setups_ingredients
end
