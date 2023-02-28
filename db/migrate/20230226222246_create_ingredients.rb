# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients, id: :uuid do |t|
      # GLOBAL_TABLE
      t.string :name, null: false
      t.text :description
      t.string :diet_tags, array: true, default: [] # ["vegan", "vegeterian", "sattvic"]

      t.timestamps

      t.index :name, unique: true
    end
  end
end
