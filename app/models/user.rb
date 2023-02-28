# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  KINDS = {
    anonymous: 'anonymous',
    real: 'real'
  }.freeze

  enum :kind, KINDS, _default: 'anonymous'

  has_many :phones, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :users_roles, dependent: :destroy
  has_many :roles, through: :users_roles
  has_many :users_directly_assigned_permissions, dependent: :destroy
  has_many :directly_assigned_permissions, through: :users_directly_assigned_permissions
  has_many :users_forbidden_ingredients, dependent: :destroy
  has_many :forbidden_ingredients, through: :users_forbidden_ingredients

  accepts_nested_attributes_for :emails

  scope :by_email, lambda { |email|
    joins(:emails).where(emails: { email: })
  }
end
