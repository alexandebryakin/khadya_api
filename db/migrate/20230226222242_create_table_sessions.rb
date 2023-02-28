# frozen_string_literal: true

class CreateTableSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :table_sessions, id: :uuid do |t|
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :ended_at

      t.references :table, type: :uuid

      t.timestamps
    end
  end
end
