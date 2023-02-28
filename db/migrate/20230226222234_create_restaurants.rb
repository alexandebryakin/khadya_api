# frozen_string_literal: true

class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants, id: :uuid do |t|
      t.string :name, null: false
      # - location (lng & lat)
      t.string :currency_code, default: 'USD', null: false

      t.timestamps

      t.references :network, type: :uuid
    end
  end
end
