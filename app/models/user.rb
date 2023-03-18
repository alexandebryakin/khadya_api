# frozen_string_literal: true

class User < ApplicationRecord
  ANONYMOUS_USER_PASSWORD = '1234'

  has_secure_password

  enum :kind, {
    anonymous: 'anonymous',
    real: 'real'
  }, default: 'anonymous', prefix: true

  has_many :phones, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :users_roles, dependent: :destroy
  has_many :roles, through: :users_roles
  has_many :users_directly_assigned_permissions, dependent: :destroy
  has_many :directly_assigned_permissions, through: :users_directly_assigned_permissions
  has_many :users_forbidden_ingredients, dependent: :destroy
  has_many :forbidden_ingredients, through: :users_forbidden_ingredients
  has_one :network, dependent: :destroy
  has_many :restaurants, through: :network

  accepts_nested_attributes_for :emails

  scope :by_email, lambda { |email|
    joins(:emails).where(emails: { email: })
  }
end
