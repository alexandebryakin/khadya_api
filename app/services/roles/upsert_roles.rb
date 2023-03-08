# frozen_string_literal: true

module Roles
  class UpsertRoles
    def self.crud(entity)
      [
        "#{Permissions::UpsertPermissions::CREATE}_#{entity}",
        "#{Permissions::UpsertPermissions::READ}_#{entity}",
        "#{Permissions::UpsertPermissions::UPDATE}_#{entity}",
        "#{Permissions::UpsertPermissions::DELETE}_#{entity}"
      ]
    end

    ROLES = {
      network_manager: crud('network') + %w[
      ],
      restaurant_manager: crud('restaurant') + %w[
      ],
      regular_user: crud('order') + crud('table_session') + %w[
      ]
    }.freeze

    def call
      validate!

      ROLES.each do |role_code, permission_codes|
        role = Role.find_or_create_by!(role_code)
        role.permissions << Permission.where(code: permission_codes)
      end
    end

    private

    def validate!
      return if missing_permission_codes_in_db.blank?

      raise "Missing permissions in the DB found: #{missing_permission_codes_in_db}"
    end

    def missing_permission_codes_in_db
      @missing_permission_codes_in_db ||= begin
        actual_permission_codes = Permission.pluck(:code)
        roles_permission_codes = ROLES.values.flatten.uniq

        roles_permission_codes - actual_permission_codes
      end
    end
  end
end
