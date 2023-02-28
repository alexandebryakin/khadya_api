# frozen_string_literal: true

class CreateRestaurantsEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants_employees, id: :uuid do |t|
      t.references :restaurant, type: :uuid
      t.references :user, type: :uuid

      t.timestamps
    end
  end
end
