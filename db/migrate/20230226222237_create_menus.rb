# frozen_string_literal: true

class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus, id: :uuid do |t|
      t.references :restaurant, type: :uuid

      t.timestamps
    end
  end
end
