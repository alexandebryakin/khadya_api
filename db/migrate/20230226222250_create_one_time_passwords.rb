# frozen_string_literal: true

class CreateOneTimePasswords < ActiveRecord::Migration[7.0]
  def change
    create_table :one_time_passwords, id: :uuid do |t|
      t.integer :otp, null: false
      t.boolean :is_confirmed, default: false, null: false

      t.references :phone, type: :uuid

      t.timestamps
    end
  end
end
