# frozen_string_literal: true

class CreateMealSetupsIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :meal_setups_ingredients, id: :uuid do |t|
      t.references :meal_setup, type: :uuid
      t.references :ingredient, type: :uuid

      t.timestamps
    end
  end
end
