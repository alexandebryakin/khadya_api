# frozen_string_literal: true

class UsersForbiddenIngredient < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
end
