# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items, id: :uuid do |t|
      t.datetime :removed_at
      t.datetime :started_cooking_at
      t.datetime :finished_cooking_at
      t.datetime :delivered_at

      t.references :meal_setup, type: :uuid
      t.references :order, type: :uuid

      t.timestamps
    end
  end
end
