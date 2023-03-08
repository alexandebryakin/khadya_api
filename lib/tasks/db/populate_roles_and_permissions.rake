# frozen_string_literal: true

namespace :db do
  task populate_roles_and_permissions: :environment do
    Permissions::UpsertPermissions.new.call
    Roles::UpsertRoles.new.call
  end
end
