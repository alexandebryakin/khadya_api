# frozen_string_literal: true

class CreateChecks < ActiveRecord::Migration[7.0]
  def change
    create_table :checks, id: :uuid do |t|
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
