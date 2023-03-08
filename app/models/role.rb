# frozen_string_literal: true

class Role < ApplicationRecord
  enum :kind, {
    custom: 'custom',
    app: 'app'
  }, default: 'custom', prefix: true

  has_many :permissions, through: :roles_permissions

  # I can't use the following, since it generates some method and enum stops working:
  # validates uniqueness: { scope: %i[restaurant_id kind] }
end
