# frozen_string_literal: true

class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals, id: :uuid do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :cooking_duration
      t.string :category, null: false

      t.references :menu, type: :uuid

      t.timestamps
    end
  end
end
