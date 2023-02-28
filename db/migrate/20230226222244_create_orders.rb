# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :status, default: 'initial', null: false

      t.references :user, type: :uuid
      t.references :table_session, type: :uuid
      t.references :check, type: :uuid

      t.timestamps
    end
  end
end
