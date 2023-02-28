# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :password_digest

      t.string :first_name
      t.string :last_name
      t.string :language_code, default: 'en-us', null: false # https://www.andiamo.co.uk/resources/iso-language-codes/
      t.string :kind, default: 'anonymous', null: false

      t.timestamps

      t.index :kind
    end
  end
end
