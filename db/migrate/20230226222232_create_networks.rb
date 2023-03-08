# frozen_string_literal: true

class CreateNetworks < ActiveRecord::Migration[7.0]
  def change
    create_table :networks, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps

      t.references :user, type: :uuid
    end
  end
end
