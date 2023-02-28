# frozen_string_literal: true

class CreateUsersForbiddenIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :users_forbidden_ingredients, id: :uuid do |t|
      t.references :user, type: :uuid
      t.references :ingredient, type: :uuid

      t.timestamps
    end
  end
end
