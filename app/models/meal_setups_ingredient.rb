# frozen_string_literal: true

class MealSetupsIngredient < ApplicationRecord
  belongs_to :meal_setup
  belongs_to :ingredient
end
