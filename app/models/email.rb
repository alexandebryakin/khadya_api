# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :user

  enum :verification_status, Phone.verification_statuses, default: 'in_progress', prefix: true

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
