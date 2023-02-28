# frozen_string_literal: true

class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables, id: :uuid do |t|
      t.string :name
      t.integer :number
      t.integer :seats_amount

      t.references :restaurant, type: :uuid

      t.timestamps
    end
  end
end
