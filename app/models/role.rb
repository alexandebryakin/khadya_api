# frozen_string_literal: true

class Role < ApplicationRecord
  KINDS = {
    custom: 'custom',
    app: 'app'
  }.freeze

  enum :kind, KINDS, _default: 'custom'

  has_many :permissions, through: :roles_permissions

  validates uniqueness: { scope: %i[restaurant_id kind] }
end
