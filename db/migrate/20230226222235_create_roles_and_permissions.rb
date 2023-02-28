# frozen_string_literal: true

class CreateRolesAndPermissions < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    create_table :roles, id: :uuid do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :kind, default: 'custom', null: false

      t.references :restaurant, type: :uuid # for `custom` roles

      t.timestamps

      t.index :code, unique: true
    end

    create_table :permissions, id: :uuid do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :token_code, null: false

      t.timestamps

      t.index :code, unique: true
    end

    create_table :roles_permissions, id: :uuid do |t|
      t.references :role, type: :uuid
      t.references :permission, type: :uuid

      t.timestamps
    end

    create_table :users_roles, id: :uuid do |t|
      t.references :user, type: :uuid
      t.references :role, type: :uuid

      t.timestamps
    end

    create_table :users_directly_assigned_permissions, id: :uuid do |t|
      t.references :user, type: :uuid
      t.references :permission, type: :uuid

      t.timestamps
    end
  end
end
