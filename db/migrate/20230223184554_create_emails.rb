# frozen_string_literal: true

class CreateEmails < ActiveRecord::Migration[7.0]
  def change
    enable_extension('citext')

    create_table :emails, id: :uuid do |t|
      t.citext :email
      t.string :verification_status, default: 'in_progress', null: false
      t.boolean :is_primary, default: false, null: false

      t.references :user, type: :uuid

      t.timestamps

      t.index :email, unique: true
    end
  end
end
