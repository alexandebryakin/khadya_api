# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones, id: :uuid do |t|
      t.integer :code
      t.integer :number
      t.string :verification_status, default: 'in_progress', null: false
      t.boolean :is_primary, default: false, null: false

      t.references :user, type: :uuid

      t.timestamps

      t.index %i[code number], unique: true
    end
  end
end
