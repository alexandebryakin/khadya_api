# frozen_string_literal: true

class CreateMealSetups < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :meal_setups, id: :uuid do |t|
      t.string :label
      t.string :kind, default: 'main', null: false
      t.boolean :is_available, default: true
      t.integer :kcalories, null: false
      t.integer :volume, null: false
      t.string :volume_measurement, null: false
      t.decimal :price, precision: 10, scale: 2

      t.references :meal, type: :uuid

      t.timestamps
    end
  end
end
