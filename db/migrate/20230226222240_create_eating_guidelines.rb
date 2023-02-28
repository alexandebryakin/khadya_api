# frozen_string_literal: true

class CreateEatingGuidelines < ActiveRecord::Migration[7.0]
  def change
    create_table :eating_guidelines, id: :uuid do |t|
      t.text :content

      t.references :meal, type: :uuid

      t.timestamps
    end
  end
end
