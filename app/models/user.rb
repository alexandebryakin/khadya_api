# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :phones, dependent: :destroy
  has_many :emails, dependent: :destroy

  accepts_nested_attributes_for :emails

  scope :by_email, lambda { |email|
    joins(:emails).where(emails: { email: })
  }
end
